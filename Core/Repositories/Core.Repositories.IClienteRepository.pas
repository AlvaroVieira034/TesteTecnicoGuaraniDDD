unit Core.Repositories.IClienteRepository;

interface

uses
  System.Generics.Collections,
  Core.Entities.Cliente;

type
  IClienteRepository = interface
    ['{DFF87B83-118E-4518-A636-94E288DAAC30}']

    function ObterPorId(AId: Integer): TCliente;
    function ObterPorCNPJ(ACNPJ: string): TCliente;
    function ListarTodos: TObjectList<TCliente>;
    function ListarPorCidade(ACidade: string): TObjectList<TCliente>;
    function ListarPorNome(ANome: string): TObjectList<TCliente>;

    procedure Adicionar(ACliente: TCliente);
    procedure Atualizar(ACliente: TCliente);
    procedure Remover(AId: Integer);

    function ProximoId: Integer;
    function ExisteCNPJ(ACNPJ: string; AExcluirId: Integer = 0): Boolean;
    function ExisteRazaoSocial(ARazaoSocial: string; AExcluirId: Integer = 0): Boolean;
  end;

implementation

end.
