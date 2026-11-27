# Smoke test isolado da grade semanal da Rádio Gospel Hits.
# Não acessa playlists, rede, Icecast, AutoDJ ou dados de produção.
# Playlists substituídas por fontes blank() apenas para validar tipos e sintaxe.

pl_super_sequencia = blank()
pl_classic_hits = blank()
pl_gospel_beats = blank()
pl_conexao_hits = blank()
pl_hits_brasil = blank()
pl_gospel_rock = blank()
pl_pop_hits = blank()
pl_ultimo_volume = blank()
pl_gospel_club = blank()

grade_gospelhits = switch(
  id="gh_grade_semanal_smoke_test",
  track_sensitive=true,
  [
    ({12h-13h}, pl_super_sequencia),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 13h-14h}, pl_classic_hits),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 14h-15h}, pl_gospel_beats),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 15h-17h}, pl_conexao_hits),
    ({(1w or 2w or 3w or 4w or 5w) and 17h-18h}, pl_hits_brasil),
    ({6w and 17h-18h}, pl_gospel_rock),
    ({6w and 18h-21h}, pl_pop_hits),
    ({(1w or 2w or 3w or 4w) and 21h-24h}, pl_ultimo_volume),
    ({(5w or 6w) and 21h-24h}, pl_gospel_club)
  ]
)

# Mantem a grade como fonte verificavel sem iniciar transmissao.
ignore(grade_gospelhits)
