import '../caixa_eletronico.dart';
import '../caixa_eletronico.dart';
import '../caixa_eletronico_estado.dart';

class CodigoSegurancaCorreto implements CaixaEletronicoEstado {
  CodigoSegurancaCorreto();

  void initialize(CaixaEletronico caixaEletronico) {
    if(_caixaEletronico!= null) throw Exception("Objeto já está inicializado !");
    _caixaEletronico = caixaEletronico;
  }

  CaixaEletronico _caixaEletronico;

  bool _caixaEstaInicializado() {
    if (_caixaEletronico == null) {
      throw Exception("Você esqueceu de initializar o caixa eletronico !");
    } else {
      return true;
    }
  }

  @override
  Future<void> inserirCodigoSeguranca(String codigo) {
    if (_caixaEstaInicializado()) {
      throw Exception("Código de Segurança já foi inserido !!\n");
    }
  }

  @override
  Future<void> inserirCartao() {
    if (_caixaEstaInicializado()) {
      throw Exception("Não pode ser inseridos dois cartões !!\n");
    }
  }

  @override
  Future<void> removerCartao() {
    if (_caixaEstaInicializado()) {
      print("Cartão removido !\n");
      _caixaEletronico.estado = _caixaEletronico.semCartao;
    }
  }

  @override
  Future<void> solicitarGrana(double dinheiro) {
    if (_caixaEstaInicializado()) {
      if (_caixaEletronico.granaEmCaixa <= 0) {
        _imprimirMensagemSemGrana();
        _caixaEletronico.estado = _caixaEletronico.semGrana;
      } else if (dinheiro > _caixaEletronico.granaEmCaixa) {
        _imprimirMensagemSemGrana();
        removerCartao();
      } else {
        print("R\$$dinheiro sacado");
        _caixaEletronico.saque(dinheiro);
        removerCartao();
      }
    }
  }

  void _imprimirMensagemSemGrana() =>
      print("Sem dinheiro nesse caixa eletronico !");
}
