const mockServerClient = require('mockserver-client').mockServerClient;
const {mockHost,  mockPort} = require('./mock.config');

mockServerClient(mockHost, mockPort)
    .mockAnyResponse({
        httpRequest: {
            method: 'GET',
            path: 'health/alb',
        },
        httpResponse: {
            statusCode: 204,
        },
    }).then(() => {
        console.log('exectation created');
    }).catch(error => {
        console.log(error);
    });