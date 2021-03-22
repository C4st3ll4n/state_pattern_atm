import 'package:caixa_eletronico_state/test/helpers/mock_class/caixa_estado_mock.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import '../../src/caixa_eletronico.dart';
import '../../src/estados/estados.dart';

void main() {
  SemGranaCaixaEletronico semGrana;
  CaixaEletronico caixaEletronico;

  setUp(() {
    caixaEletronico = CaixaEletronico();
    semGrana = SemGranaCaixaEletronico();

    caixaEletronico.initialize(
        comCartaoEstado: CaixaEstadoSpy.mockComCartao(),
        semCartaoEstado:  CaixaEstadoSpy.mockSemCartao(),
        semGranaEstado: semGrana,
        codigoSegurancaEstado:  CaixaEstadoSpy.mockComCodigo(),
        granaNoCaixa: 0);

    semGrana.initialize(caixaEletronico);

  });


  test("Deve inicializar com os estados corretos", () async {
    expect(caixaEletronico.estado, caixaEletronico.semGrana);
  });

  test("Não pode inserir cartão", () async {
    expect(() async => semGrana.inserirCartao(),
        throwsA((e) => e is Exception));
  });


  test("Não pode remover cartão", () async {
    expect(() async => semGrana.removerCartao(),
        throwsA((e) => e is Exception));
  });


  test("Não pode inserir código de segurança", () async {
    expect(() async =>
        semGrana.inserirCodigoSeguranca(faker.randomGenerator.string(4)),
        throwsA((e) => e is Exception));
  });


  test("Não pode solicitar grana", () async {
    expect(() async => semGrana.solicitarGrana(faker.randomGenerator.decimal()),
        throwsA((e) => e is Exception));
  });
}
