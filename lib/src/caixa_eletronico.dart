import 'caixa_eletronico_estado.dart';
import 'package:meta/meta.dart';

class CaixaEletronico implements CaixaEletronicoEstado {
  CaixaEletronicoEstado _temCartaoInseridoEstado;
  CaixaEletronicoEstado _semCartaoInseridoEstado;
  CaixaEletronicoEstado _caixaSemGranaEstado;
  CaixaEletronicoEstado _codigoSegurancaCorretoEstado;

  CaixaEletronicoEstado _caixaEletronicoEstado;

  bool inseriuCodigoSegurancaCorreto = false;
  double _granaEmReaisNoCaixa;

  static const int MAX_TENTATIVAS = 3;

  set estado(CaixaEletronicoEstado estado) => _caixaEletronicoEstado = estado;

  CaixaEletronicoEstado get estado => _caixaEletronicoEstado;

  CaixaEletronicoEstado get semCartao => _semCartaoInseridoEstado;

  CaixaEletronicoEstado get comCartao => _temCartaoInseridoEstado;

  CaixaEletronicoEstado get semGrana => _caixaSemGranaEstado;

  CaixaEletronicoEstado get codigoSegurancaCorreto =>
      _codigoSegurancaCorretoEstado;

  double get granaEmCaixa => _granaEmReaisNoCaixa;

  CaixaEletronico();

  CaixaEletronico initialize(
      {@required comCartaoEstado,
      @required semCartaoEstado,
      @required semGranaEstado,
      @required codigoSegurancaEstado,
      double granaNoCaixa = 3500}) {
    _temCartaoInseridoEstado = comCartaoEstado;
    _semCartaoInseridoEstado = semCartaoEstado;
    _caixaSemGranaEstado = semGranaEstado;
    _codigoSegurancaCorretoEstado = codigoSegurancaEstado;

    _granaEmReaisNoCaixa = granaNoCaixa;
    if (granaNoCaixa <= 0) estado = semGrana;
    else estado = semCartao;

    return this;
  }

  @override
  Future<void> inserirCodigoSeguranca(String codigo) {
    _caixaEletronicoEstado.inserirCodigoSeguranca(codigo);
  }

  @override
  Future<void> inserirCartao() {
    _caixaEletronicoEstado.inserirCartao();
  }

  @override
  Future<void> removerCartao() {
    _caixaEletronicoEstado.removerCartao();
  }

  @override
  Future<void> solicitarGrana(double dinheiro) {
    _caixaEletronicoEstado.solicitarGrana(dinheiro);
  }

  void saque(double dinheiro) {
    _granaEmReaisNoCaixa -= dinheiro;
  }

  @override
  String toString() {
    return '{_caixaEletronicoEstado: $_caixaEletronicoEstado, inseriuCodigoSegurancaCorreto: $inseriuCodigoSegurancaCorreto, _granaEmReaisNoCaixa: $_granaEmReaisNoCaixa}';
  }
}
