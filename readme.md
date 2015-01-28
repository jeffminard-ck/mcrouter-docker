# mcrouter

A docker container for [Facebook's mcrouter](https://www.facebook.com/Engineering/posts/10152044187717200)

## Usage

Just run the container, it'll show you the help options

```
docker run -p 5000:5000 jmck/mcrouter:1.0
```

Now, run two (or more) memcache containers:

```
docker run -d --name memcached0 memcached
docker run -d --name memcached1 memcached
docker run -d -p 5000:5000 --link=memcached0:memcached0 --link=memcached1:memcached1 jmck/mcrouter mcrouter --config-str='{"pools":{"A":{"servers":["memcached0:11211", "memcached1:11211"]}},"route":"PoolRoute|A"}' -p 5000
```

Now we can use mcrouter as a regular memcache server!

```
$  telnet 192.168.59.103 5000
Trying 192.168.59.103...
Connected to 192.168.59.103.
Escape character is '^]'.
stats
STAT version mcrouter 1.0
STAT commandargs --config-str={"pools":{"A":{"servers":["memcached0:11211", "memcached1:11211"]}},"route":"PoolRoute|A"} -p 5000
...etc...
```
