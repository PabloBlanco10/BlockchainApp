const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3')
const compiledCarChain = require('./build/CarChain.json');

const provider = new HDWalletProvider(
    'bid brain coin law pact hurry humor party exact cattle join coin', 
    'https://rinkeby.infura.io/v3/911ffdd646fe4561820ce1c146be7250'
)
const web3 = new Web3(provider)

const deploy = async () => {
    const accounts = await web3.eth.getAccounts()

    console.log('Attempting to deploy from acc', accounts[0])

    const result = await new web3.eth.Contract(JSON.parse(compiledCarChain.interface))
    .deploy({data : compiledCarChain.bytecode })
    .send({gas: '1000000', from: accounts[0]})

    console.log(compiledCarChain.interface)
    console.log('Contract deployed to', result.options.address)
}
deploy()