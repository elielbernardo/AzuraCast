# Radio Gospel Hits - grade semanal e rotacao comercial
# Liquidsoap 2.4.6 | America/Sao_Paulo
#
# Este arquivo e carregado automaticamente pelo ConfigWriter depois que
# as playlists nativas da estacao foram declaradas.
#
# Regra comercial: 6 faixas musicais, seguidas por um bloco com:
# saida de bloco, 3 anuncios intercalados por vinhetas, retorno de bloco.
# Super Sequencia (12h-13h) permanece sem comerciais internos.

time.zone.set("America/Sao_Paulo")

# Um bloco comercial completo. once() limita cada playlist a uma faixa
# por passagem, permitindo a composicao sequencial sem repetir a playlist
# de anuncios indefinidamente dentro do mesmo bloco.
gh_bloco_comercial = sequence(
  id="gh_bloco_comercial",
  [
    once(playlist_compartilhado___comerciais___saida_de_bloco),
    once(playlist_compartilhado___comerciais___anuncios),
    once(playlist_compartilhado___comerciais___vhts_entre_comerciais),
    once(playlist_compartilhado___comerciais___anuncios),
    once(playlist_compartilhado___comerciais___vhts_entre_comerciais),
    once(playlist_compartilhado___comerciais___anuncios),
    once(playlist_compartilhado___comerciais___volta_de_bloco)
  ]
)

# A cada seis musicas, executa um bloco comercial.
# Cada programa regular tem seu proprio contador; a Super Sequencia
# e deliberadamente excluida desta rotacao.
gh_classic_hits = rotate(
  id="gh_rotacao_classic_hits",
  weights=[6, 1],
  [playlist_classic_hits, gh_bloco_comercial]
)

gh_gospel_beats = rotate(
  id="gh_rotacao_gospel_beats",
  weights=[6, 1],
  [playlist_gospel_beats, gh_bloco_comercial]
)

gh_conexao_hits = rotate(
  id="gh_rotacao_conexao_hits",
  weights=[6, 1],
  [playlist_conexao_hits, gh_bloco_comercial]
)

gh_hits_brasil = rotate(
  id="gh_rotacao_hits_brasil",
  weights=[6, 1],
  [playlist_hits_brasil, gh_bloco_comercial]
)

gh_gospel_rock = rotate(
  id="gh_rotacao_gospel_rock",
  weights=[6, 1],
  [playlist_gospel_rock, gh_bloco_comercial]
)

gh_pop_hits = rotate(
  id="gh_rotacao_pop_hits",
  weights=[6, 1],
  [playlist_pop_hits, gh_bloco_comercial]
)

gh_ultimo_volume = rotate(
  id="gh_rotacao_ultimo_volume",
  weights=[6, 1],
  [playlist_ultimo_volume, gh_bloco_comercial]
)

gh_gospel_club = rotate(
  id="gh_rotacao_gospel_club",
  weights=[6, 1],
  [playlist_gospel_club, gh_bloco_comercial]
)

# Grade semanal: programas regulares com comerciais e Super Sequencia
# sem comerciais. Fora dos horarios, usa a rotacao geral do AutoDJ.
gh_grade_semanal = switch(
  id="gh_grade_semanal",
  track_sensitive=true,
  [
    ({12h-13h}, playlist_super_sequencia),

    ({(1w or 2w or 3w or 4w or 5w or 6w) and 13h-14h}, gh_classic_hits),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 14h-15h}, gh_gospel_beats),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 15h-17h}, gh_conexao_hits),

    ({(1w or 2w or 3w or 4w or 5w) and 17h-18h}, gh_hits_brasil),
    ({6w and 17h-18h}, gh_gospel_rock),
    ({6w and 18h-21h}, gh_pop_hits),

    ({(1w or 2w or 3w or 4w) and 21h-24h}, gh_ultimo_volume),
    ({(5w or 6w) and 21h-24h}, gh_gospel_club)
  ]
)

gh_rotacao_geral = rotate(
  id="gh_rotacao_geral",
  weights=[6, 1],
  [radio, gh_bloco_comercial]
)

# A grade e a rotacao comercial ficam abaixo das filas nativas:
# AutoDJ, pedidos e interrupcoes continuam sendo aplicados pelo AzuraCast.
radio = fallback(
  id="gh_grade_com_rotacao_geral",
  track_sensitive=true,
  [
    gh_grade_semanal,
    gh_rotacao_geral
  ]
)

log("GOSPEL HITS: grade semanal e blocos comerciais carregados")
