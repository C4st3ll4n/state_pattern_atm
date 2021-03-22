import 'package:caixa_eletronico_state/test/helpers/mock_class/caixa_estado_mock.dart';
import 'package:test/test.dart';
import 'package:caixa_eletronico_state/src/caixa_eletronico.dart';
import 'package:caixa_eletronico_state/src/caixa_eletronico_estado.dart';
import 'package:caixa_eletronico_state/src/estados/estados.dart';

void main() {
  double totalGrana;
  CaixaEletronico caixaEletronico;

  CaixaEletronicoEstado temCartaoInseridoEstado;
  CaixaEletronicoEstado semCartaoInseridoEstado;
  CaixaEletronicoEstado caixaSemGranaEstado;
  CaixaEletronicoEstado codigoSegurancaCorretoEstado;

  setUp(() {
    totalGrana = 5000;
    caixaEletronico = CaixaEletronico();

    temCartaoInseridoEstado = CaixaEstadoSpy("Com cartão");
    semCartaoInseridoEstado = CaixaEstadoSpy("Sem cartão");
    caixaSemGranaEstado = CaixaEstadoSpy("Sem grana");
    codigoSegurancaCorretoEstado = CaixaEstadoSpy("Com código");

    caixaEletronico.initialize(comCartaoEstado: temCartaoInseridoEstado,
        semCartaoEstado: semCartaoInseridoEstado,
        semGranaEstado: caixaSemGranaEstado,
        codigoSegurancaEstado: codigoSegurancaCorretoEstado);
  });

  test("Checar inicialização", () {
    expect(caixaEletronico.estado, caixaEletronico.semCartao);
    expect(caixaEletronico.granaEmCaixa, totalGrana);
    expect(caixaEletronico.inseriuCodigoSegurancaCorreto, false);
    expect(caixaEletronico.semGrana, caixaSemGranaEstado);
  });

  test("Não permitir saque quando caixa estiver sem grana ", () {
    caixaEletronico.saque(totalGrana);

    caixaEletronico.inserirCartao();
    caixaEletronico.inserirCodigoSeguranca("123");
    expect(caixaEletronico.inseriuCodigoSegurancaCorreto, false);

    caixaEletronico.inserirCodigoSeguranca("123");
    expect(caixaEletronico.inseriuCodigoSegurancaCorreto, false);

    caixaEletronico.inserirCodigoSeguranca("1234");
    expect(caixaEletronico.inseriuCodigoSegurancaCorreto, true);
    caixaEletronico.solicitarGrana(500);

    expect(caixaEletronico.estado, caixaEletronico.semGrana);
  });
}
