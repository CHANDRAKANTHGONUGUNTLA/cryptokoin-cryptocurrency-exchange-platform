from flask import Flask, url_for, render_template, request, session, redirect
from flask_session import Session
import time
import datetime
import json
from user_ckn import user
from collections import Counter, defaultdict
from cryptokoin_apis import cryptokoin_api

app = Flask(__name__)

app.config['SECRET_KEY'] = '56hdtryhRTg'
app.config['SESSION_PERMANENT'] = True
app.config['SESSION_TYPE'] = 'filesystem'
app.config['PERMANENT_SESSION_LIFETIME'] = datetime.timedelta(minutes=30) 

sess = Session()
sess.init_app(app)


@app.route('/')  
def home(): 
    return render_template('homepage.html',navigation_items=False)

@app.context_processor
def inject_user():
    return dict(
        me=session.get('user'),
        navigation_items=session.get('user') is not None  
    )

@app.route('/create_account', methods=['GET', 'POST'])
def create_account():
    u = user()  
    u.createBlank()  
    
    if request.method == 'POST':
        u.data[0]['username'] = request.form.get('username').lower() if request.form.get('username') else ''
        u.data[0]['email'] = request.form.get('email').lower() if request.form.get('email') else ''
        u.data[0]['password_hash'] = request.form.get('password_hash')
        u.data[0]['password2'] = request.form.get('retypepassword')
        u.data[0]['role'] = 'user'  
        u.data[0]['wallet_balance'] = 0  # Initial wallet balance
        u.data[0]['created_at'] = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        u.data[0]['referrals'] = 0
        referral_name = request.form.get('referral')
        referral_code = referral_name if referral_name else ''
        
        if u.verify_new():
            u.insert()
            if referral_code != '':
                referral_code = referral_code.lower()
                u.getAll()
                names = [ i['username'] for i in u.data]
                if referral_code in names:
                    u.getByField('username',referral_code)
                    u.data[0]['referrals'] +=1
                    u.update()
                else:
                    pass         
            else:
                pass
            
            session['user'] = u.data[0]
            session['active'] = time.time()
            return redirect(url_for('user_mainmenu'))
        
        else:
            return render_template("create_account.html", u=u,navigation_items=False)  
    return render_template("create_account.html", u=u,navigation_items=False)

@app.route('/login',methods = ['GET','POST'])
def login():
    if request.form.get('username') is not None and request.form.get('password') is not None:
        u = user()
        user_name = request.form.get('username')
        if u.tryLogin(user_name.lower(),request.form.get('password')):
            session['user'] = u.data[0]
            session['active'] = time.time()
            if session['user']['role'] == 'user':
                return redirect(url_for('user_mainmenu')) 
            else:
                return redirect(url_for('admin_mainmenu'))
        else:
            return render_template('login.html', title='Login', msg='Incorrect username or password.',navigation_items=False)
    else:   
        if 'msg' not in session.keys() or session['msg'] is None:
            m = 'Type your email and password to continue.'
        else:
            m = session['msg']
            session['msg'] = None
        return render_template('login.html', title='Login', msg=m,navigation_items=False)    
    
@app.before_request
def track_session_timeout():
    # Ensure the session is marked as permanent
    session.permanent = True

    # If the user is logged in
    if 'user' in session:
        # Check for session expiration
        login_time = session.get('login_time')
        if not login_time:
            session['login_time'] = datetime.datetime.now()
        else:
            elapsed = datetime.datetime.now() - login_time
            if elapsed.total_seconds() > app.config['PERMANENT_SESSION_LIFETIME'].total_seconds():
                # Save logout info and clear session
                user_id = session['user']['user_id']

                u = user()
                u.tn = 'User_Activity'
                u.fields = []
                u.getFields()
                u.createBlank()
                u.data[0] = dict(zip(u.fields,[ session['login_time'], datetime.datetime.now(),user_id ]))
                u.insert()
                session.clear()
                return redirect(url_for('login'))  

@app.route('/logout')
def logout():
    if 'user' in session:
        user_id = session['user']['user_id']
        login_time = session.get('login_time', datetime.datetime.now()) 
        
        u = user()
        u.tn = 'User_Activity'
        u.fields = []
        u.getFields()
        u.createBlank()
        u.data[0] = dict(zip(u.fields,[ login_time, datetime.datetime.now(),user_id]))
        u.insert()
        session.clear()
    return render_template('login.html', title='Login', msg='You have logged out.',navigation_items=False)


@app.route("/reset_password", methods=['GET', 'POST'])
def reset_password():
    u = user()  
    if request.method == 'POST':
        u.data = [{
            'username': request.form.get('username').lower(),
            'email': request.form.get('email').lower(),
            'password_hash': request.form.get('password_hash'),
            'password2': request.form.get('retypepassword')
        }]
        if u.verify_update(0):
            u.getByField('username',request.form.get('username').lower())
            u.data[0]['password_hash'] = u.hashPassword(request.form.get('password_hash'))
            u.update()           
            return render_template('login.html',msg = 'Password Changed Successfully!',navigation_items=False)
        else:
            return render_template('reset_password.html', errors=u.errors,navigation_items=False)

    return render_template('reset_password.html',navigation_items=False)

@app.route('/mainmenu/rewards/referrals')
def referral():
    username_ = session['user']['username']
    return render_template('referral.html', username = username_.upper(),navigation_items=True)

@app.route('/mainmenu/rewards/cryptokoin')
def coin_launch():
    return render_template('coin_launch.html',navigation_items=True)

@app.route("/mainmenu/market")
def market():
    u = user()
    u.tn = 'Crypto_coins'
    u.getAll() 
    return render_template('market.html', coins= u.data,navigation_items=True)

# Coin Details Route
@app.route('/details/<coin_id>')
def coin_details(coin_id):
    u = user()
    u.tn = 'Crypto_coins'
    u.getByField('coin_symbol',coin_id)
    coin = None
    if len(u.data)>0:   
        coin = u.data[0]

    if not coin:
        return render_template('details.html', message="Coin not found"), 404
    
    # Fetch candlestick data using yfinance
    try:
        graph_html = cryptokoin_api.candle_stick_graph(coin)
        
    except Exception as e:
        graph_html = f"<p>Error generating chart: {e}</p>"

    return render_template('details.html', graph_html=graph_html, coin=coin, navigation_items=True)

@app.route("/mainmenu/trade", methods=['GET', 'POST'])
def trade():
    u = user()
    user_id = session['user']['user_id']
    u.tn = 'User_data'
    u.getById(user_id)
    wallet_balance = float(u.data[0]['wallet_balance'])
    
    sql = '''SELECT 
            c.cryptocoin_id, c.coin_symbol, c.coin_name, c.current_price, c.image_url, IFNULL(SUM(CASE WHEN t.transaction_type = 'BUY' THEN t.quantity 
            WHEN t.transaction_type = 'SELL' THEN -t.quantity ELSE 0 END), 0) AS shares_owned
        FROM Crypto_coins c LEFT JOIN Transaction_History t ON c.cryptocoin_id = t.crypto_id AND t.user_id = %s
        GROUP BY c.cryptocoin_id, c.coin_symbol, c.coin_name, c.current_price, c.image_url;
        '''
    u.cur.execute(sql, user_id)
    coins = u.cur.fetchall()
    
    msg = None
    msg_type = None

    if request.method == 'POST':
        trade_type = request.form['trade_type']  # 'buy' or 'sell'
        coin_symbol = request.form['crypto']
        shares = float(request.form['shares'])
        
        u.tn = 'Crypto_coins'
        u.getByField('coin_symbol', coin_symbol)
        coin = u.data[0]
        if not coin:
            msg = "Invalid cryptocurrency selected."
            msg_type = "error"
            return render_template('trade.html', coins=coins, wallet_balance=wallet_balance, msg=msg, msg_type=msg_type)

        crypto_id = coin['cryptocoin_id']
        coin_price = float(coin['current_price'])
        total_price = round(shares * coin_price,2)
        tax = round((total_price * 0.03),2)      # 3% tax
        final_amount = total_price + tax if trade_type == 'buy' else total_price - tax

        if trade_type == 'buy':
            if wallet_balance < final_amount:
                msg = "Insufficient wallet balance."
                msg_type = "error"
            else:
                wallet_balance -= final_amount
                wallet_balance = wallet_balance

                u.tn = 'User_data'
                u.getById(user_id)
                u.data[0]['wallet_balance'] = wallet_balance
                u.update()
                u.data.clear()
                msg = f"You successfully purchased {shares} shares of {coin_symbol} for ${final_amount:.2f}."
                msg_type = "success"

        elif trade_type == 'sell':
            coin_data = next((coin for coin in coins if coin['coin_symbol'] == coin_symbol), None)
            if coin_data:
                owned_shares = coin_data['shares_owned']  # Get shares owned directly from coins data
            else:
                owned_shares = 0

            if shares > owned_shares:
                msg = "Insufficient shares to sell."
                msg_type = "error"
            else:
                wallet_balance += final_amount
                wallet_balance = round(wallet_balance, 2)

                
                u.tn = 'User_data'
                u.getById(user_id)
                u.data[0]['wallet_balance'] = wallet_balance
                u.update()
                u.data.clear()
                msg = f"You sold {shares} shares of {coin_symbol} for ${final_amount:.2f}."
                msg_type = "success"
        
        u = user()
        u.tn = 'Transaction_History'
        u.fields = []
        u.getFields()
        u.createBlank()
        u.data[0] = dict(zip(u.fields,[ trade_type,shares,coin_price, datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), user_id, crypto_id,final_amount,tax]))
        u.insert()

    return render_template('trade.html', coins=coins, wallet_balance=wallet_balance, msg=msg, msg_type=msg_type, navigation_items=True)

@app.route('/mainmenu/wallet/deposit', methods=['GET', 'POST'])
def deposit():
    user_id = session['user']['user_id']
    u = user()
    u.getById(user_id)
    balance = float(u.data[0]['wallet_balance'])
    msg = None
    msg_type = None
    
    if request.method == 'POST':
        cardholder_name = request.form.get('cardholder_name')
        card_number = request.form.get('card_number')
        expiry_date = request.form.get('expiry_date')
        cvv = request.form.get('cvv')
        amount = float(request.form.get('amount'))

        if cardholder_name and card_number and expiry_date and cvv and amount:
            amount = float(amount)
            if amount >= 10:
                balance+= amount               
                u.data[0]['wallet_balance'] = balance
                u.update()
                
                u.tn = 'Wallet_Transaction_History'
                u.fields = []
                u.getFields()
                u.createBlank()
                u.data[0] = dict(zip(u.fields,['Deposit', amount, datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), user_id]))
                u.insert()
                
                msg = f" ${amount}  is successfully deposited into your wallet"
                msg_type ="success"
                return render_template('wallet_deposit.html', wallet_balance= balance,msg = msg,msg_type= msg_type)
                
            else:
                msg = "Amount is less than $10"
                msg_type ="error"     
                return render_template('wallet_deposit.html', wallet_balance= balance,msg = msg,msg_type= msg_type)   
            
        else:
            msg = "All fields are required for deposit!"
            msg_type = "error"
            return render_template('wallet_deposit.html', wallet_balance= balance,msg = msg,msg_type= msg_type)

    return render_template('wallet_deposit.html', wallet_balance= balance,navigation_items=True)

@app.route('/mainmenu/wallet/withdraw', methods=['GET', 'POST'])
def withdraw():
    user_id = session['user']['user_id']
    u = user()
    u.getById(user_id)
    balance = float(u.data[0]['wallet_balance'])
    
    msg = None
    msg_type = None

    if request.method == 'POST':
        withdraw_amount = request.form.get('withdraw_amount')
        bank_name = request.form.get('bank_name')
        bank_account = request.form.get('bank_account')

        if withdraw_amount and bank_name and bank_account:
            try:
                withdraw_amount = float(withdraw_amount)

                if withdraw_amount < 10:
                    msg = "Withdrawal amount must be at least $10."
                    msg_type = "error"

                elif withdraw_amount > balance:
                    msg = "Insufficient wallet balance for this transaction."
                    msg_type = "error"

                else:
                    balance -= float(withdraw_amount)
                    u.data[0]['wallet_balance'] = balance
                    u.update()

                    u.tn = 'Wallet_Transaction_History'
                    u.fields = []
                    u.getFields()
                    u.createBlank()
                    u.data[0] = dict(zip(u.fields,['Withdraw',withdraw_amount,  datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"), user_id]))
                    u.insert()
                    msg = f"${withdraw_amount:.2f} has been successfully withdrawn to your {bank_name} account (Account: {bank_account})."
                    msg_type = "success"

            except ValueError:
                msg = "Invalid withdrawal amount. Please enter a valid number."
                msg_type = "error"

        else:
            msg = "All fields are required for the withdrawal process!"
            msg_type = "error"

    return render_template('wallet_withdraw.html', wallet_balance=balance, msg=msg, msg_type=msg_type)

@app.route('/mainmenu/wallet/transactions')
def wallet_transactions():
    u = user()
    user_id = session['user']['user_id']
    u.tn = 'Wallet_Transaction_History'
    u.getByField('user_id',user_id)
    wallet_transactions = u.data
    wallet_transactions = sorted(wallet_transactions, key=lambda x: x['transaction_timestamp'], reverse=True)
    return render_template('wallet_transactions.html',transactions = wallet_transactions , navigation_items=True)

@app.route('/mainmenu/investments')
def investments():
    user_id = session['user']['user_id']
    u = user()
    user_id = 3
    cryptokoin_api.currency_update()
    sql = '''SELECT cc.image_url, cc.coin_id, cc.coin_symbol, cc.coin_name, th.transaction_type,th.quantity, th.total_amount, th.transaction_timestamp
                FROM `Transaction_History` th, Crypto_coins cc WHERE th.crypto_id = cc.cryptocoin_id AND th.user_id = %s'''
    u.cur.execute(sql, user_id)
    check = u.cur.fetchall()
    result = cryptokoin_api.calculate_profit_loss(check)
    cb = sum(r['current_balance'] for r in result)
    return render_template('investments.html', investments = result, i_price = cb, navigation_items=True)  

@app.route('/mainmenu/transactions')
def transactions():
    user_id = session['user']['user_id']
    u= user()
    sql = '''SELECT cc.image_url,cc.coin_name,th.transaction_type,th.quantity,th.total_amount,th.transaction_timestamp
    FROM `Transaction_History` th, Crypto_coins cc WHERE th.crypto_id = cc.cryptocoin_id AND th.user_id =%s ORDER BY `th`.`transaction_timestamp` DESC'''
    u.cur.execute(sql,user_id)
    return render_template('transactions.html',transactions = u.cur.fetchall() , navigation_items=True)

@app.route('/mainmenu/account/profile')
def profile():
    user_id = session['user']['user_id']
    u= user()
    u.getById(user_id)
    u_details = u.data[0]
    u_details['username'] = u_details['username'].upper()
    u_details['created_at'] = u_details['created_at'].strftime("%B %d, %Y") 
    return render_template('user_profile.html',user = u_details, navigation_items=True)

@app.route("/mainmenu")
def user_mainmenu():
    u = user()
    cryptokoin_api.currency_update()
    u.tn = 'User_data'
    user_id = session['user']['user_id']
    u.getById(user_id)
    wb = u.data[0]['wallet_balance']
    wb = float(wb)

    sql = '''SELECT cc.image_url, cc.coin_id, cc.coin_symbol, cc.coin_name, th.transaction_type,th.quantity, th.total_amount, th.transaction_timestamp
            FROM `Transaction_History` th, Crypto_coins cc WHERE th.crypto_id = cc.cryptocoin_id AND th.user_id = %s'''
    u.cur.execute(sql, user_id)
    check = u.cur.fetchall()

    result = cryptokoin_api.calculate_profit_loss(check)
    cb = sum(r['current_balance'] for r in result)
    cb = float(cb)
    

    u = user()
    u.tn = 'Crypto_coins'
    u.getAll()
    sorted_data = sorted(u.data, key=lambda x: x['price_change_percentage_24h'], reverse=True)

    return render_template(
        'user_mainmenu.html', coins=sorted_data, navigation_items=True, crypto_balance=cb, wallet_balance=wb, liquid_value=cb + wb, user_assets=result)
    
@app.route('/admin_mainmenu')
def admin_mainmenu():
    
    # User Growth Chart Data
    u = user()
    cryptokoin_api.currency_update()
    u.getAll()
    data = u.data
    date_counts = Counter(us['created_at'].date() for us in data if us['role'] == 'user')
    
    # Get all dates between the earliest and latest user creation dates
    start_date = min(date_counts.keys())
    end_date = max(date_counts.keys())
    all_dates = [start_date + datetime.timedelta(days=i) for i in range((end_date - start_date).days + 1)]
    
    # Accumulate user count over time, filling missing dates with last known value
    cumsum_dict = {}
    last_count = 0
    for date in all_dates:
        if date in date_counts:
            last_count += date_counts[date]
        cumsum_dict[date.strftime("%Y-%m-%d")] = last_count
    
    t_users = last_count  

    # Daily Transactions Data
    u = user()
    sql = '''SELECT cc.image_url, ud.username, cc.coin_name, th.transaction_type, th.quantity, th.total_amount, th.tax, DATE(th.transaction_timestamp) AS transaction_date
    FROM `Transaction_History` th 
    JOIN Crypto_coins cc ON th.crypto_id = cc.cryptocoin_id 
    JOIN User_data ud ON th.user_id = ud.user_id 
    ORDER BY th.transaction_timestamp ASC;'''
    u.cur.execute(sql)
    data = u.cur.fetchall()

    transactions_format = defaultdict(lambda: {"revenue": 0, "details": {"buys": 0, "sells": 0}})

    # Prepare transaction data for each day
    min_date = min([trans['transaction_date'] for trans in data])
    max_date = datetime.date.today()
    all_transaction_dates = [min_date + datetime.timedelta(days=i) for i in range((max_date - min_date).days + 1)]

    for trans in data:
        date_str = trans['transaction_date'].strftime('%Y-%m-%d')
        transactions_format[date_str]["revenue"] += trans['tax']
        if trans['transaction_type'] == 'sell':
            transactions_format[date_str]["details"]["sells"] += 1
        else:
            transactions_format[date_str]["details"]["buys"] += 1

    # Fill missing dates with 0 revenue and transaction details
    transactions_list = []
    for date in all_transaction_dates:
        date_str = date.strftime('%Y-%m-%d')
        if date_str in transactions_format:
            transactions_list.append({"date": date_str, "revenue": float(transactions_format[date_str]["revenue"]), "details": transactions_format[date_str]["details"]})
        else:
            transactions_list.append({"date": date_str, "revenue": 0, "details": {"buys": 0, "sells": 0}})

    # Total revenue calculation (ignores missing dates)
    t_revenue = sum(float(tr['revenue']) for tr in transactions_list)


    # Top Users Data
    user_totals = defaultdict(float)
    for d in data:
        user_totals[d['username']] += float(d['total_amount'])
    
    top_users_list = [{"username": user, "transaction_amount": amount} for user, amount in user_totals.items()]
    top_users_list = sorted(top_users_list, key=lambda x: x["transaction_amount"], reverse=True)

    # Cryptocurrency Distribution Data
    crypto_data = {}
    for d in data:
        if d['coin_name'] in crypto_data.keys():
            crypto_data[d['coin_name']] = crypto_data[d['coin_name']] + float(d['total_amount'])
        else:
            crypto_data[d['coin_name']] = float(d['total_amount'])

    # Process crypto data for pie chart
    def process_crypto_data(data):
        sorted_data = sorted(data.items(), key=lambda x: x[1], reverse=True)
        top5 = sorted_data[:5]
        others = sorted_data[5:]
        
        others_value = sum(value for _, value in others)
        
        final_data = top5 + [("Others", others_value)]
        total_value = sum(value for _, value in final_data)
        
        processed_data = [
            {"name": name, "value": value, "percentage": round((value / total_value) * 100, 2)}
            for name, value in final_data]
        
        return processed_data

    processed_crypto_data = process_crypto_data(crypto_data)

    return render_template('admin_dashboard.html',
        def_data=json.dumps(cumsum_dict),
        crypto_data=json.dumps(processed_crypto_data),
        transactions=json.dumps(transactions_list),
        t_users=t_users,
        t_revenue=t_revenue,
        top_users=json.dumps(top_users_list[:5]))

def admin_base():
    return render_template('admin_base.html')

@app.route("/admin_mainmenu/user_management")
def user_management():
    u = user()
    u.getAll() 
    data = u.data
    data = [u for u in data if u['role'] == 'user']
    return render_template('admin_user_management.html', users= data)

@app.route("/admin_mainmenu/transactions")
def admin_transactions():
    u = user()
    sql = '''SELECT ud.username,cc.coin_name,th.transaction_type,th.quantity,th.price_at_transaction,th.tax,th.total_amount,th.transaction_timestamp
            FROM Transaction_History th, User_data ud, Crypto_coins cc WHERE th.user_id = ud.user_id AND th.crypto_id = cc.cryptocoin_id ORDER BY `th`.`transaction_timestamp` DESC'''
    u.cur.execute(sql)
    return render_template('admin_transactions.html', users= u.cur.fetchall())

@app.route("/admin_mainmenu/wallet_transactions")
def admin_wallet_transactions():
    u = user()
    sql = '''SELECT ud.username,wth.transaction_type,wth.Amount,wth.transaction_timestamp FROM Wallet_Transaction_History wth, User_data ud WHERE wth.user_id = ud.user_id ORDER BY `wth`.`transaction_timestamp` DESC'''
    u.cur.execute(sql)
    return render_template('admin_wallet_transactions.html', users= u.cur.fetchall())

@app.route("/admin_mainmenu/market")
def admin_market():
    u = user()
    u.tn = 'Crypto_coins'
    u.getAll() 
    return render_template('admin_market.html', coins= u.data,navigation_items=True)

# Coin Details Route
@app.route('/admin_coin_details/<coin_id>')
def admin_coin_details(coin_id):
    u = user()
    u.tn = 'Crypto_coins'
    u.getByField('coin_symbol',coin_id)
    coin = None
    if len(u.data)>0:   
        coin = u.data[0]

    if not coin:
        return render_template('admin_coin_details.html', message="Coin not found"), 404
    
    # Fetch candlestick data using yfinance
    try:
        graph_html = cryptokoin_api.candle_stick_graph(coin)
    except Exception as e:
        graph_html = f"<p>Error generating chart: {e}</p>"

    return render_template('admin_coin_details.html', graph_html=graph_html, coin=coin, navigation_items=True)

@app.route('/admin_profile')
def admin_profile():
    user_id = session['user']['user_id']
    u= user()
    u.getById(user_id)
    u_details = u.data[0]
    u_details['username'] = u_details['username'].upper()
    u_details['created_at'] = u_details['created_at'].strftime("%B %d, %Y") 
    return render_template('admin_profile.html',user = u_details, navigation_items=True)

if __name__ == '__main__':
    app.run(host='127.0.0.1',debug=True)  


