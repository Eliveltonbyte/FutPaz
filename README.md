# FutPaz
App para gerenciamento de jogos 

alteração para fazer 
procedure TFrmJogador.ListaSemConsulta;
begin
//implementar tduo
  lvAtletas.BeginUpdate;
  lvAtletas.Items.Clear;

  with DMTABELAS.FDAtletas do
  begin
    active := false;
    SQL.Clear;
    SQL.ADD('select * from atletas order by id');
    active := true;

    while NOT DMTabelas.FDAtletas.eof do
     begin
      AddPedido(DMTABELAS.FDAtletas.fieldbyname('id').asString,
                DMTABELAS.FDAtletas.fieldbyname('atleta').asString,
                DMTABELAS.FDAtletas.fieldbyname('posicao').asString,
                DMTABELAS.FDAtletas.fieldbyname('status').asString);

                DMTabelas.FDAtletas.Next;
     end;

  end;
end;
