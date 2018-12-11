# Advent Calendar of Advanced Cyber Fun 2018
Gimme m0ar cyber funZ!1

## Agenda

| Port | Challenge | Path |
| ---- | --------- | ---- |
| 1    | TCPMUX ([RFC1078](https://tools.ietf.org/html/rfc1078)) service: Assigned TCP port 1 by IANA ([RFC1700](https://tools.ietf.org/html/rfc1700)). | [tcpmux](tcpmux) 
| 2    | XMASbleed (CVE-2014-0160): Heartbleed with christmas fun! | [xmasbleed](xmasbleed)
| 3    | HTTPoSCTP: HTTP over SCTP, a poor man's implementation of [draft-natarajan-http-over-sctp-00.txt](https://tools.ietf.org/html/draft-natarajan-http-over-sctp-00). | [sctphttp](sctphttp)
| 4    | KnockKnock: A webserver that is only accessible after knocking on TCP port sequence `42 23 16 15 8`. | [knockknock](knockknock)
| 5    | HTTPS with Client Certificate: Accessing the webserver requires a client certificate that includes `christmas` in the Common Name field. | [tlsclientcert](tlsclientcert)
| 6    | SERIAL Challenge. It is required to talk to two sockets. One read only and one write only. | [serial](serial)
| 7    | XMASHTTP: A webserver that implements a special **XMAS** HTTP method | [xmashttp](xmashttp)
| 8    | TLS ChaCha: A HTTPS server that is only accessible with ChaCha20 based ciper suites. | [tlschacha](tlschacha)
| 9    | eBPF filter with magic keyword. C code will be provided. | [ebpf](ebpf)
| 10   | .NET Remoting Server. pcap will be provided. | [remoting](remoting)
| 11   | PlainSSH: A patched OpenSSH server that only allows connections with "none" ciphers. Requires a patched OpenSSH client, maybe provide patch for OpenSSH v6.8. | [plainssh](plainssh)
| 12   | TLS13: A HTTPS server that only supports TLSv1.3. | [tls13](tls13)
| 18   | Message Send Procotol 2: Python implementation of [RFC1312](https://tools.ietf.org/html/rfc1312). Users need to send a message to a specific user with a signature. Code for signature creation/checking will be provided? |
| 23   | SSH Layer 3 VPN: A internal host that is only accessible from local IP address via layer 3 VPN. |

## Potential Challenges

* Webapp with websockets
* Shellcode generator mit Antwort einer billigen rechnung mov eax,1; add eax,2
* [QUIC](https://ma.ttias.be/googles-quic-protocol-moving-web-tcp-udp/)
    * Some implementations are available
        * [Playing with QUIC](https://www.chromium.org/quic/playing-with-quic)
        * [quic-py](https://github.com/ZhukovAlexander/quic-py)
        * [quic-go](https://github.com/lucas-clemente/quic-go)
    * [HTTP over QUIC](https://tools.ietf.org/html/draft-ietf-quic-http-03)
        * it's a current draft, could be interesting to implement a poor man's version.
* TLS
    * algorithms that are not widely supported/used, maybe PSK cipher suites.
* TLS-SRP
* TLS with client cert
    * requires to be signed by Christmas Inc. CA
    * required different types of certs?
* IPv6
    * IPv6 only service
    * TLS port with client cert, requires IPv6 address in CN
* Special HTTP server
    * HTTP server that requires special user-agent and referrer header.
* JAVA RMI?
* HTTP over UDP
    * Nginx/Apache with socat
    * probably implement UDP handler for aiohttp?
        * should work by implementing a [low-level server](https://docs.aiohttp.org/en/stable/web_lowlevel.html#run-a-basic-low-level-server) with [loop.create_unix_server](https://docs.python.org/3/library/asyncio-eventloop.html#asyncio.loop.create_server) and socat.
        * maybe implement a loop.create_udp_server?
* UDP port with DTLS
* iptable/BPF rules with a pattern where useless/reserved/unnecessary bits have to be set or else the packets will be dropped.
    * Implement check for the [evil bit](https://blog.benjojo.co.uk/post/evil-bit-RFC3514-real-world-usage)
    * Implement checks for reserved fields in TCP header
* TCP multiplexer
    * run HTTP/HTTPS and SSH on the same port
        * probably just fork [this](https://github.com/draplater/tcpmux)
    * run HTTP/HTTPS and any other protocol on the same port?
* HTTP Proxy that injects JavaScript snow into pages

## Development Setup

Create a development VM with pre-installed Docker:

```bash
vagrant up
vagrant ssh
```

Within the VM, you can build the Docker containers:

```bash
cd /vagrant/tcpmux
sudo docker build -t day01_tcpmux .
sudp docker run -d --restart=always -p 1:1 --name=day01 day01_tcpmux
```

The VM creates a second host-only interface by default, which should expose the services.