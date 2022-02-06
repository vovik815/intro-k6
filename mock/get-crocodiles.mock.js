const mockServerClient = require('mockserver-client').mockServerClient;
const {mockHost,  mockPort} = require('./mock.config');

const fs = require('fs');
const path = require('path');

const jsonResponse = JSON.parse(
    fs.readFileSync(path.resolve(__dirname, 'crocodiles.response.json'))
);

mockServerClient(mockHost, mockPort)
    .mockAnyResponse({
        httpRequest: {
            method: 'GET',
            path: '/public/crocodiles',
        },
        httpResponse: {
            statusCode: 200,
            body: JSON.stringify(jsonResponse),
            headers: [
                {
                    name: 'Content-type',
                    values: ['application/json'],
                },
            ],
        },
    }).then(() => {
        console.log('exectation created');
    }).catch(error => {
        console.log(error);
    });