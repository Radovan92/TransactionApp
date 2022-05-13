import 'package:flutter/services.dart';
import 'package:transaction_app/constants.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class Functions {
  late Web3Client web3client;
  late http.Client httpClient;

  void initital() {
    httpClient = http.Client();
    String moralisApi =
        'https://speedy-nodes-nyc.moralis.io/cb0ba2ff086e2bec9a36df2c/eth/kovan';
    web3client = Web3Client(moralisApi, httpClient);
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString('assets/abi.json');
    final contract = DeployedContract(
        ContractAbi.fromJson(abi, 'TransactionApp'),
        EthereumAddress.fromHex(publicAddress));

    return contract;
  }

  Future getBalance() async {
    final contract = await getDeployedContract();
    final etherFunction = contract.function('getBalance');
    final result = await web3client
        .call(contract: contract, function: etherFunction, params: []);
    List<dynamic> res = result;
    return res[0];
  }

  Future<String> sendWithdrawBalance(int amount, String name) async {
    var bigAmount = BigInt.from(amount);
    EthPrivateKey privateKeyCred = EthPrivateKey.fromHex(privateKey);
    DeployedContract contract = await getDeployedContract();
    final ethFunction = contract.function(name);
    final result = await web3client.sendTransaction(
        privateKeyCred,
        Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: [bigAmount],
          maxGas: 100000,
        ),
        chainId: 4,
        fetchChainIdFromNetworkId: false);
    return result;
  }
}
