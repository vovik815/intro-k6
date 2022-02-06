const vuserLog = msg => console.log(`[Vuser: ${__VU}][Iteration: ${__ITER}] ${msg}`);

const logFailedCheck = response =>
    console.log(
        'Check failed!!',
        `Request headers: ${JSON.stringify(response.request.headers)}`,
        `Request body: ${JSON.stringify(response.request.body)}`,
        `Response status: ${JSON.stringify(response.status)}`,
        `Response headers: ${JSON.stringify(response.headers)}`,
        `Response body: ${JSON.parse(response.body).daznSource}`
    );

module.exports = { vuserLog, logFailedCheck };
