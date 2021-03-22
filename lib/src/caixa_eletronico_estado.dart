abstract class CaixaEletronicoEstado{
  Future<void> inserirCartao();
  Future<void> removerCartao();
  Future<void> inserirCodigoSeguranca(String codigo);
  Future<void> solicitarGrana(double dinheiro);
}