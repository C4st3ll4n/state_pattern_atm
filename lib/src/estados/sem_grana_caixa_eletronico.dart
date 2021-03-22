import '../caixa_eletronico.dart';
import '../caixa_eletronico_estado.dart';

class SemGranaCaixaEletronico implements CaixaEletronicoEstado {
  SemGranaCaixaEletronico();

  CaixaEletronico _caixaEletronico;

  void _imprimirMensagem() =>
      throw Exception("Sem dinheiro nesse caixa eletronico !");

  @override
  Future<void> inserirCodigoSeguranca(String codigo) async {
    if (_caixaEstaInicializado()) {
      return _imprimirMensagem();
    }
  }

  @override
  Future<void> inserirCartao() async {
    if (_caixaEstaInicializado()) {
      return _imprimirMensagem();
    }
  }

  @override
  Future<void> removerCartao() async {
    if (_caixaEstaInicializado()) {
      return _imprimirMensagem();
    }
  }

  @override
  Future<void> solicitarGrana(double dinheiro) async {
    if (_caixaEstaInicializado()) {
      return _imprimirMensagem();
    }
  }

  void initialize(CaixaEletronico caixaEletronico) {
    if(_caixaEletronico!= null) throw Exception("Objeto já está inicializado !");
    _caixaEletronico = caixaEletronico;
  }

  bool _caixaEstaInicializado() {
    if (_caixaEletronico == null) throw Exception("Você esqueceu de initializar o caixa eletronico !");
    else return true;
  }
}
