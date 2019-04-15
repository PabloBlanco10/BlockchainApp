const path = require('path');
const solc = require('solc');
const fs = require('fs-extra');

const buildPath = path.resolve(__dirname, 'build');
fs.removeSync(buildPath);


const carChainPath = path.resolve(__dirname, 'contracts', 'CarChain.sol');
const source = fs.readFileSync(carChainPath, 'utf8');

const output = solc.compile(source, 1).contracts;

fs.ensureDirSync(buildPath);

for (let contract in output) {
    console.log(contract);
    fs.outputJSONSync(
        path.resolve(buildPath, contract.replace(':', '') + '.json'),
        output[contract]
    );

    fs.outputJSONSync(
        path.resolve(buildPath, 'Interface' + '.json'),
        output[contract].interface
    );
    console.log(output[contract].interface);
} 
