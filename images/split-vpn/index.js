const fs = require('node:fs');
const path = require('node:path');
const { Resolver } = require('node:dns');
const { exec } = require("child_process");

const addRoute = async (ip) => {
    const command = `ip route add ${ip} via 10.3.2.1 dev wg0`
    console.log(command)
    exec(command)
}

const updateRoutes = async () => {
    const domainsFile = (await fs.promises.readFile(path.join(__dirname, 'domain_list'))).toString()
    const domains = domainsFile.split('\r\n').filter(domain => domain.length > 0);

    const resolver = new Resolver();
    resolver.setServers(['8.8.8.8', '4.4.4.4']);

    const ips = await Promise.all(
        domains.map(domain => new Promise((resolve, reject) => {
            resolver.resolve4(domain, (err, addresses) => {
                if (err) {
                    reject(err)
                } else {
                    resolve(addresses)
                }
            })
        }))
    )

    const flatIps = ips.flat()
    const dedupedIps = [...new Set(flatIps)]

    console.log('Updating routes', JSON.stringify(dedupedIps))
    dedupedIps.forEach(ip => addRoute(ip))
}

const routesPoll = async () => {
    for (let i = 0; i < 10; i++) {
        try {
            await updateRoutes()
            await new Promise(resolve => setTimeout(resolve, 1_000))
        } catch(e) {
            console.error(e)
        }
    }
}

routesPoll()

setInterval(() => {
    routesPoll()
}, 60_000)