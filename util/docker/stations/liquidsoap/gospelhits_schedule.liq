# Radio Gospel Hits - grade semanal centralizada
# Inserir em: custom_config_post_playlists
# Liquidsoap 2.4.6 | Fuso America/Sao_Paulo
#
# Usa as playlists nativas que o ConfigWriter ja declarou.
# O hook custom_config_post_playlists executa ANTES de AutoDJ,
# fila de pedidos e fila de interrupcoes. Assim, as filas nativas
# permanecem com prioridade sobre a programacao.

time.zone.set("America/Sao_Paulo")

# Programas especiais; fora dos horarios definidos, a rotacao nativa
# do AzuraCast continua sendo a fonte de fallback.
gh_grade_semanal = switch(
  id="gh_grade_semanal",
  track_sensitive=true,
  [
    # Super Sequencia - todos os dias, 12h as 13h
    ({12h-13h}, playlist_super_sequencia),

    # Segunda a sabado
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 13h-14h}, playlist_classic_hits),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 14h-15h}, playlist_gospel_beats),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 15h-17h}, playlist_conexao_hits),

    # Segunda a sexta
    ({(1w or 2w or 3w or 4w or 5w) and 17h-18h}, playlist_hits_brasil),

    # Sabado
    ({6w and 17h-18h}, playlist_gospel_rock),
    ({6w and 18h-21h}, playlist_pop_hits),

    # Segunda a quinta
    ({(1w or 2w or 3w or 4w) and 21h-24h}, playlist_ultimo_volume),

    # Sexta e sabado
    ({(5w or 6w) and 21h-24h}, playlist_gospel_club)
  ]
)

# A grade substitui somente a fonte musical de base.
# AutoDJ, pedidos e interrupcoes sao aplicados pelo AzuraCast logo depois.
radio = fallback(
  id="gh_grade_com_rotacao_geral",
  track_sensitive=true,
  [
    gh_grade_semanal,
    radio
  ]
)

log("GOSPEL HITS: grade semanal carregada antes das filas nativas")
