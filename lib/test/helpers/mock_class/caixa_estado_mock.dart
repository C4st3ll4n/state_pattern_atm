import 'package:mockito/mockito.dart';

import '../../../src/caixa_eletronico_estado.dart';
class CaixaEstadoSpy extends Mock implements CaixaEletronicoEstado {
  CaixaEstadoSpy(this.TAG);
  final String TAG;

  @override
  String toString() {
    return TAG;
  }


  static CaixaEletronicoEstado mockComCartao() => CaixaEstadoSpy("Com cartão");
  static CaixaEletronicoEstado mockSemCartao() => CaixaEstadoSpy("Sem cartão");
  static CaixaEletronicoEstado mockSemGrana() => CaixaEstadoSpy("Sem grana");
  static CaixaEletronicoEstado mockComCodigo() => CaixaEstadoSpy("Com codigo");

}
