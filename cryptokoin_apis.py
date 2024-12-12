from collections import defaultdict
import requests
from datetime import datetime
from user_ckn import user,baseObject
import yfinance as yf
import plotly.graph_objects as go

class cryptokoin_api:
    
    @staticmethod
    def fetch_current_prices(coins):
        coin_ids = ",".join(coins)
        url = f"https://api.coingecko.com/api/v3/simple/price?ids={coin_ids}&vs_currencies=usd"
        try:
            response = requests.get(url)
            if response.status_code == 200:
                return response.json()
            else:
                print(f"Failed to fetch prices, status code: {response.status_code}")
                return {}
        except Exception as e:
            print(f"Error fetching prices: {e}")
            return {}

    @staticmethod
    def calculate_profit_loss(transactions):
        holdings = defaultdict(float)
        investments = defaultdict(float)
        coin_details = {}
        coins = {txn['coin_id'] for txn in transactions}
        current_prices = cryptokoin_api.fetch_current_prices(coins)

        for txn in transactions:
            coin = txn['coin_id']
            quantity = txn['quantity']
            total_amount = txn['total_amount']
            txn_type = txn['transaction_type']

            if coin not in coin_details:
                coin_details[coin] = {
                    "image_url": txn['image_url'],
                    "coin_name": txn['coin_name'],
                    "coin_symbol": txn['coin_symbol'],
                }

            if txn_type == 'buy':
                holdings[coin] += float(quantity)
                investments[coin] += float(total_amount)

            elif txn_type == 'sell':
                if holdings[coin] >= float(quantity):
                    average_cost_per_share = investments[coin] / holdings[coin]
                    sold_investment = average_cost_per_share * float(quantity)
                    holdings[coin] -= float(quantity)
                    investments[coin] -= sold_investment
                else:
                    raise ValueError(f"Attempted to sell more {coin} than owned!")

        results = []
        for coin, quantity in holdings.items():
            if float(quantity) <= 0:
                continue

            current_price = current_prices.get(coin, {}).get("usd", 0)
            current_balance = current_price * float(quantity)
            investment_value = investments[coin]
            profit_loss = current_balance - investment_value
            percentage_change = (profit_loss / investment_value) * 100 if investment_value != 0 else 0

            results.append({
                "coin_id": coin,
                "coin_name": coin_details[coin]["coin_name"],
                "coin_symbol": coin_details[coin]["coin_symbol"],
                "image_url": coin_details[coin]["image_url"],
                "quantity": round(float(quantity), 4),
                "investment_value": round(investment_value, 2),
                "current_price": round(current_price, 2),
                "current_balance": round(current_balance, 2),
                "profit_loss": round(profit_loss, 2),
                "percentage_change": round(percentage_change, 2)
            })

        return results
    
    @staticmethod
    def currency_update():
        import pymysql, requests, json
        from datetime import datetime

        # Define currencies (IDs for CoinGecko)
        currencies = {'btc': 'bitcoin', 'eth': 'ethereum', 'bnb': 'binancecoin', 'sol': 'solana', 'trx': 'tron', 'ton': 'the-open-network', 'ada': 'cardano', 'avax': 'avalanche-2', 'bch': 'bitcoin-cash', 'sui': 'sui', 'near': 'near', 'apt': 'aptos', 'icp': 'internet-computer', 'xmr': 'monero', 'kas': 'kaspa', 'fil': 'filecoin', 'cro': 'crypto-com-chain', 'inj': 'injective-protocol', 'ftm': 'fantom', 'hbar': 'hedera-hashgraph', 'atom': 'cosmos', 'om': 'mantra-dao', 'sei': 'sei-network', 'algo': 'algorand', 'ar': 'arweave', 'flow': 'flow', 'core': 'coredaoorg', 'gala': 'gala', 'xec': 'ecash', 'flr': 'flare-networks', 'egld': 'elrond-erd-2', 'xtz': 'tezos', 'gno': 'gnosis', 'chz': 'chiliz', 'ron': 'ronin', 'aioz': 'aioz-network', 'rose': 'oasis-network', 'astr': 'astar', 'iota': 'iota', 'kava': 'kava', 'wemix': 'wemix-token', 'zeta': 'zetachain', 'elf': 'aelf', 'enj': 'enjincoin', 'dcr': 'decred', 'xch': 'chia', 'qubic': 'qubic-network', 'xrd': 'radix', 'skl': 'skale', 'kda': 'kadena', 'glmr': 'moonbeam', 'ozo': 'ozone-chain', 'one': 'harmony', 'chr': 'chromaway', 'heart': 'humans-ai', 'alph': 'alephium', 'zano': 'zano', 'waxp': 'wax', 'azero': 'aleph-zero', 'orai': 'oraichain-token', 'vanry': 'vanar-chain', 'cspr': 'casper-network', 'hive': 'hive', 'movr': 'moonriver', 'dusk': 'dusk-network', 'omni': 'omni-network', 'sys': 'syscoin', 'cudos': 'cudos', 'tet': 'tectum', 'oas': 'oasys', 'erg': 'ergo', 'lto': 'lto-network', 'kuji': 'kujira', 'lyx': 'lukso-token-2', 'ela': 'elastos', 'qanx': 'qanplatform', 'ctxc': 'cortex', 'ccd': 'concordium', 'ngl': 'entangle', 'meld': 'meld-2', 'trias': 'trias-token', 'bld': 'agoric', 'wan': 'wanchain', 'vic': 'tomochain', 'dnx': 'dynex', 'stos': 'stratos', 'jkl': 'jackal-protocol', 'glq': 'graphlinq-protocol', 'route': 'router-protocol-2', 'fio': 'fio-protocol', 'saito': 'saito'}
        ids = ",".join(currencies.values())
        
        #testing with top 30 coins
        tt_ids = ",".join(list(currencies.values())[:30])

        try:
            # Fetch data from CoinGecko API
            url = f"https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids={tt_ids}&order=market_cap_desc"
            response = requests.get(url)
            data = response.json()
            ordered_data = []
            ids_order = list(currencies.values())[:30]  # First 30 IDs
            id_to_data = {item['id']: item for item in data}  # Map IDs to their corresponding data

            for coin_id in ids_order:
                if coin_id in id_to_data:
                    ordered_data.append(id_to_data[coin_id])

            # Connect to database
            conn = pymysql.connect(host='mysql.clarksonmsda.org', port=3306, user='gonuguc',
                                passwd='Chandu@1604', db='gonuguc_CryptoKoiN', autocommit=True)
            cur = conn.cursor(pymysql.cursors.DictCursor)

            # Clear existing data
            sql = 'TRUNCATE TABLE Crypto_coins;'
            cur.execute(sql)

            # SQL Insert Query
            sql = f'''
            INSERT INTO Crypto_coins (
                coin_id, coin_symbol, coin_name, image_url, current_price, market_cap,
                market_cap_rank, total_volume, price_change_percentage_24h, high_24h, low_24h,
                ath, ath_change_percentage, circulating_supply, last_updated,price_change_24h
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s)
            '''

            for coin in ordered_data:
                ts = datetime.strptime(coin['last_updated'], "%Y-%m-%dT%H:%M:%S.%fZ").strftime("%Y-%m-%d %H:%M:%S")
                val = (
                    coin['id'], coin['symbol'], coin['name'], coin['image'], coin['current_price'], coin['market_cap'],
                    coin['market_cap_rank'], coin['total_volume'], coin['price_change_percentage_24h'],
                    coin['high_24h'], coin['low_24h'], coin['ath'], coin['ath_change_percentage'],
                    coin['circulating_supply'], ts, coin['price_change_24h']
                )
                cur.execute(sql, val)

        except Exception as e:
            print(f"Error: {e}")
            
            
    @staticmethod
    def candle_stick_graph(coin):
        ticker = yf.Ticker(f"{coin['coin_symbol'].upper()}-USD")
        data = ticker.history(period="1y")
        if data.empty:
            graph_html = "<p>No historical data available for this coin.</p>"
            return graph_html
        else:
            # Generate candlestick chart
            fig = go.Figure(data=[go.Candlestick(
                    x=data.index,
                    open=data['Open'],
                    high=data['High'],
                    low=data['Low'],
                    close=data['Close']
            )])
            # Add SMA
            data['20_SMA'] = data['Close'].rolling(window=20).mean()
            data['50_SMA'] = data['Close'].rolling(window=50).mean()
            fig.add_trace(go.Scatter(x=data.index, y=data['20_SMA'], mode='lines', name='20 SMA'))
            fig.add_trace(go.Scatter(x=data.index, y=data['50_SMA'], mode='lines', name='50 SMA'))

            fig.update_layout(
                    title=f"<b>{coin['coin_name']} Candlestick Chart</b>",
                    yaxis_title="Price (USD)",
                    xaxis_title="Date",
                    autosize=True,
                    margin=dict(l=20, r=20, t=40, b=20),
                    width=800
                )
            graph_html = fig.to_html(full_html=False)
            return graph_html
            
