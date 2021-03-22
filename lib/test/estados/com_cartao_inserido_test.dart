import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:caixa_eletronico_state/test/helpers/mock_class/caixa_eletronico_mock.dart';
import 'package:caixa_eletronico_state/test/helpers/mock_class/caixa_estado_mock.dart';
import '../../src/caixa_eletronico.dart';
import '../../src/estados/estados.dart';

void main() {
  ComCartaoInserido comCartao;

  CaixaEletronico caixaEletronico;

  PostExpectation _mockInserirCartao() => when(caixaEletronico.inserirCartao());
  _mockInserirCartaoCall() => _mockInserirCartao().thenAnswer((_) {
        caixaEletronico.estado = comCartao;
      });

  PostExpectation _mockInserirCodigo() =>
      when(caixaEletronico.inserirCodigoSeguranca(any));
  void _mockInserirCodigoCall() => _mockInserirCodigo().thenAnswer((_) {
        caixaEletronico.inseriuCodigoSegurancaCorreto = true;
        caixaEletronico.estado = caixaEletronico.codigoSegurancaCorreto;
      });

  void _mockInserirCodigoCallFail() =>
      when(caixaEletronico.inserirCodigoSeguranca(any))
          .thenAnswer((_) async {
            caixaEletronico.inseriuCodigoSegurancaCorreto=false;
          });

  setUp(() {
    caixaEletronico = CaixaEletronicoSpy();
    comCartao = ComCartaoInserido();

    caixaEletronico.initialize(
        comCartaoEstado: comCartao,
        semCartaoEstado: CaixaEstadoSpy.mockSemCartao(),
        semGranaEstado: CaixaEstadoSpy.mockSemGrana(),
        codigoSegurancaEstado: CaixaEstadoSpy.mockComCodigo());

    comCartao.initialize(caixaEletronico);

    caixaEletronico.inserirCartao();

    _mockInserirCartaoCall();
    _mockInserirCodigoCall();
  });

  test("Não pode inserir cartão", () async {
    expect(
        () async => comCartao.inserirCartao(), throwsA((e) => e is Exception));
  });

  test("Pode remover cartão", () async {
    comCartao.removerCartao();
    expect(caixaEletronico.estado, caixaEletronico.semCartao);
  });

  test("Pode inserir código de segurança (correto)", () async {
    comCartao.inserirCodigoSeguranca("1234");
    expect(caixaEletronico.estado, caixaEletronico.codigoSegurancaCorreto);
    expect(caixaEletronico.inseriuCodigoSegurancaCorreto, true);
  });

  test("Deve falhar ao inseriro código de segurança incorreto", () async {
    _mockInserirCodigoCallFail();
    String codigo = faker.randomGenerator.string(4);
    comCartao.inserirCodigoSeguranca(codigo);

    verify(caixaEletronico.inserirCodigoSeguranca(codigo)).called(1);

    expect(caixaEletronico.estado, caixaEletronico.comCartao);
    expect(caixaEletronico.inseriuCodigoSegurancaCorreto, false);
  });

  test("Não pode solicitar grana", () async {
    expect(
        () async => comCartao.solicitarGrana(faker.randomGenerator.decimal()),
        throwsA((e) => e is Exception));
  });
}
