import http from 'k6/http';
import { sleep, check, group } from 'k6';
import { Counter, Rate } from 'k6/metrics';
import { logFailedCheck } from './log.js';

import baseURL from './env.config.js';

const targetEnv = __ENV.TARGET_ENV || 'test';

const myFailRate = new Rate('failed requests');

export const requests = new Counter('http_reqs');

export const options = {
  stages: [
    { target: 15, duration: '30s' },
    { target: 15, duration: '1m' },
    { target: 0, duration: '30s' },
  ],
  thresholds: {
    'failed requests': ['rate<0.1'], // threshold on a custom metric
    requests: ['count < 100'],
  },
};

export default function() {

  group('GET Crocodiles', () => {
    const res = http.get(`${baseURL('mock')}/public/crocodiles`);
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
}
