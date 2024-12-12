import hashlib,datetime
from baseObject_ckn import baseObject
class user(baseObject):
    def __init__(self):
        self.setup()
        self.roles = [{'value':'admin','text':'admin'},{'value':'employee','text':'employee'},{'value':'user','text':'user'}]
    def hashPassword(self,pw):
        pw = pw+'xyz'
        return hashlib.md5(pw.encode('utf-8')).hexdigest()
    def verify_new(self,n=0):
        self.errors = []

        if self.data[n]['username'] == '':
            self.errors.append('Name cannot be blank.')
        else:
            u = user()
            u.getByField('username',self.data[n]['username'])
            if len(u.data) > 0:
                self.errors.append('Name already in use.')
                
        if self.data[n]['email'] == '':
            self.errors.append('Email cannot be blank.')
        else:
            u = user()
            u.getByField('email',self.data[n]['email'])
            if len(u.data) > 0:
                self.errors.append('Email already in use.')
        
        if self.data[n]['password_hash'] != self.data[n]['password2']:
            self.errors.append('Retyped password must match.')
        if len(self.data[n]['password_hash']) < 3:
            self.errors.append('Password needs to be more than 3 chars.')
        else:
            self.data[n]['password_hash'] = self.hashPassword(self.data[n]['password_hash'])

        if len(self.errors) > 0:
            return False
        else:
            return True
    def verify_update(self, n=0):
        self.errors = []

        username = self.data[n]['username']
        u = user()
        u.getByField('username', username)  
        
        if len(u.data) == 0:
            self.errors.append('Username not found.')
            return False
        if u.data[0]['email'] != self.data[n]['email']:
            self.errors.append('Email does not match the username.')
            
        if len(self.data[n]['password_hash']) < 3:
            self.errors.append('Password needs to be more than 3 characters.')
        
        if self.data[n]['password_hash'] != self.data[n]['password2']:
            self.errors.append('Retyped password must match.')

        if len(self.errors) == 0:
            self.data[n]['password_hash'] = self.hashPassword(self.data[n]['password_hash'])
            
        return len(self.errors) == 0

    def tryLogin(self,name, password):
        pwd = self.hashPassword(password)
        sql = f"Select * from `{self.tn}` where `username` = %s AND `password_hash` = %s;" 
        self.cur.execute(sql,(name, pwd))
        self.data = []
        for row in self.cur:
            self.data.append(row)
        if len(self.data) == 1:
            return True
        else:
            return False
        
    

        
