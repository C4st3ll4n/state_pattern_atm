import '../caixa_eletronico.dart';
import '../caixa_eletronico_estado.dart';

class ComCartaoInserido implements CaixaEletronicoEstado {
  ComCartaoInserido();

  CaixaEletronico _caixaEletronico;

  void initialize(CaixaEletronico caixaEletronico) {
    if(_caixaEletronico!= null) throw Exception("Objeto já está inicializado !");
    _caixaEletronico = caixaEletronico;
  }

  bool _caixaEstaInicializado() {
    if (_caixaEletronico == null) {
      throw Exception(
          "Você esqueceu de initializar o caixa eletronico !\n use o '.initialize()'");
    } else {
      return true;
    }
  }

  @override
  Future<void> inserirCodigoSeguranca(String codigo) {
    /// CÓDIGO DE SEGURANÇA PADRÃO => 1234
    if (_caixaEstaInicializado()) {
      if (codigo == "1234") {
        print("Código de segurança correto !");
        _caixaEletronico.inseriuCodigoSegurancaCorreto = true;
        _caixaEletronico.estado = _caixaEletronico.codigoSegurancaCorreto;
      } else {
        print("Código de segurança errado !\nTente novamente\n");
        _caixaEletronico.inseriuCodigoSegurancaCorreto = false;
      }
    }
  }

  @override
  Future<void> removerCartao() {
    if (_caixaEstaInicializado()) {
      print("Cartão removido");
      _caixaEletronico.estado = _caixaEletronico.semCartao;
    }
  }

  @override
  Future<void> inserirCartao() {
    if (_caixaEstaInicializado()) {
      throw Exception("Não pode inserir dois cartões !!!");
    }
  }

  @override
  Future<void> solicitarGrana(double dinheiro) {
    if (_caixaEstaInicializado()) {
      throw Exception("Insira o código de segruança primeiro !!!");
    }
  }
}
