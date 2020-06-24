const baseUrl = env => {
    switch (env) {
        case 'mock':    return 'http://192.168.1.11:1080';
        case 'dev':     return 'https://dev.vovik815.com';
        case 'test':    return 'https://test.vovik815.com';
        case 'stage':   return 'https://stage.vovik815.com';
        case 'prod':    return 'https://prod.vovik815.com';
        default:        return 'https://stage.vovik815.com';
    }
};

module.exports = baseUrl;
