import 'package:caixa_eletronico_state/test/helpers/mock_class/caixa_estado_mock.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import '../../src/caixa_eletronico.dart';
import '../../src/estados/estados.dart';

void main() {
  SemCartaoInserido semCartao;
  CaixaEletronico caixaEletronico;

  setUp(() {
    caixaEletronico = CaixaEletronico();
    semCartao = SemCartaoInserido();

    caixaEletronico.initialize(
        comCartaoEstado: CaixaEstadoSpy("Com cartão"),
        semCartaoEstado: semCartao,
        semGranaEstado: CaixaEstadoSpy("Sem grana"),
        codigoSegurancaEstado: CaixaEstadoSpy("Com código"));

    semCartao.initialize(caixaEletronico);


  });

  test("Deve inserir cartão", () async {
    semCartao.inserirCartao();
    expect(caixaEletronico.estado, caixaEletronico.comCartao);

    print("estado:${caixaEletronico.estado}");
  });

  test("Não pode remover cartão", () async {
    expect(
        () async => semCartao.removerCartao(), throwsA((e) => e is Exception));
  });

  test("Não pode inserir código de segurança", () async {
    expect(
        () async =>
            semCartao.inserirCodigoSeguranca(faker.randomGenerator.string(4)),
        throwsA((e) => e is Exception));
  });

  test("Não pode solicitar grana", () async {
    expect(
        () async => semCartao.solicitarGrana(faker.randomGenerator.decimal()),
        throwsA((e) => e is Exception));
  });
}
