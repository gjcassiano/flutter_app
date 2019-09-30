import datetime, requests, threading

def worker(num):
    """thread worker function"""
    while True:
        url = 'https://giovanic.com.br/'
        r = requests.get(url)
        print 'Worker: %s' % num
        


threads = []
for i in range(5):
    t = threading.Thread(target=worker, args=(i,))
    threads.append(t)
    t.start()