import 'caixa_eletronico.dart';
import 'estados/com_cartao_inserido.dart';
import 'estados/estados.dart';

CaixaEletronico makeCaixaEletronico() {
  CaixaEletronico caixaEletronico = CaixaEletronico();

  ComCartaoInserido comCartao = ComCartaoInserido();
  SemCartaoInserido semCartao = SemCartaoInserido();
  SemGranaCaixaEletronico semGrana = SemGranaCaixaEletronico();

  CodigoSegurancaCorreto comCodigoSeguranca = CodigoSegurancaCorreto();

  caixaEletronico = caixaEletronico.initialize(
      comCartaoEstado: comCartao,
      semCartaoEstado: semCartao,
      semGranaEstado: semGrana,
      codigoSegurancaEstado: comCodigoSeguranca);

  comCodigoSeguranca.initialize(caixaEletronico);
  semGrana.initialize(caixaEletronico);
  semCartao.initialize(caixaEletronico);
  comCartao.initialize(caixaEletronico);

  return caixaEletronico;
}