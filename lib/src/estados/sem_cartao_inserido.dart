import '../caixa_eletronico.dart';
import '../caixa_eletronico_estado.dart';

class SemCartaoInserido implements CaixaEletronicoEstado {
  SemCartaoInserido();

  CaixaEletronico _caixaEletronico;

  @override
  Future<void> inserirCodigoSeguranca(String codigo) {
    if (_caixaEstaInicializado()) {
      throw Exception("Insira um cartão primeiro");
    }
  }

  @override
  Future<void> inserirCartao() {
    if (_caixaEstaInicializado()) {
      print("Cartão inserido");
      _caixaEletronico.estado = _caixaEletronico.comCartao;
      print("Informe o seu código de segurança");
    }
  }

  @override
  Future<void> removerCartao() {
    if (_caixaEstaInicializado()) {
      throw Exception("Não há cartão para ser removido");
    }
  }

  @override
  Future<void> solicitarGrana(double dinheiro) {
    if (_caixaEstaInicializado()) {
      throw Exception("Insira um cartão primeiro");
    }
  }

  void initialize(CaixaEletronico caixaEletronico) {
    if(_caixaEletronico!= null) throw Exception("Objeto já está inicializado !");
    _caixaEletronico = caixaEletronico;
  }

  bool _caixaEstaInicializado() {
    if (_caixaEletronico == null) {
      throw Exception("Você esqueceu de initializar o caixa eletronico !");
    } else {
      return true;
    }
  }
}
