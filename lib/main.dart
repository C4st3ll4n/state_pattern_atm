import 'src/caixa_eletronico_factory.dart';
import 'src/caixa_eletronico.dart';

void main() {
  CaixaEletronico _caixa = makeCaixaEletronico();
  _caixa.inserirCartao();
  _caixa.inserirCodigoSeguranca("1234");
  print("\n\n");
}
