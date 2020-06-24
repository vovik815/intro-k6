import http from 'k6/http';
import { check, sleep, group } from 'k6';
import { Rate } from 'k6/metrics';

import { logFailedCheck } from './log.js';
import baseURL from './env.config.js';

const targetEnv = __ENV.TARGET_ENV || 'mock';

const myFailRate = new Rate('failed requests');

export const options =  {
    stages: [
        // ramp-up to 20 Vusers
        { target: 50, duration: '30s' },
        // constat load
        { target: 50, duration: '1m' },
        // ramp-down to 0 Vusers
        { target: 0, duration: '30s' }
    ],
    thresholds: {
        'failed requests': ['rate<0.1'], // threshold on a custom metric
        'http_req_duration': ['p(95)<500']  // threshold on a standard metric
    },
    rps: 100,
};

export default function() {
    group('GET Crocodiles', () => {
        const res = http.get(`${baseURL(targetEnv)}/public/crocodiles`);
        const checkRes = check(res, {
            'status is 200': r => r.status === 200,
            'body is not empty': res.body.length > 0,
        });
        if (!checkRes){
            myFailRate.add(!checkRes);
            logFailedCheck(res);
        }
        // sleep frmo 0-5 seconds
        sleep(Math.random() * 5 );
    });
};
