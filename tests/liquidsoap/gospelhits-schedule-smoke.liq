# Smoke test of the native-playlist integration hook.
# blank() fixtures validate syntax/types only; no audio or station services start.

playlist_super_sequencia = blank()
playlist_classic_hits = blank()
playlist_gospel_beats = blank()
playlist_conexao_hits = blank()
playlist_hits_brasil = blank()
playlist_gospel_rock = blank()
playlist_pop_hits = blank()
playlist_ultimo_volume = blank()
playlist_gospel_club = blank()
radio = blank()

time.zone.set("America/Sao_Paulo")

gh_grade_semanal = switch(
  id="gh_grade_semanal_smoke_test",
  track_sensitive=true,
  [
    ({12h-13h}, playlist_super_sequencia),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 13h-14h}, playlist_classic_hits),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 14h-15h}, playlist_gospel_beats),
    ({(1w or 2w or 3w or 4w or 5w or 6w) and 15h-17h}, playlist_conexao_hits),
    ({(1w or 2w or 3w or 4w or 5w) and 17h-18h}, playlist_hits_brasil),
    ({6w and 17h-18h}, playlist_gospel_rock),
    ({6w and 18h-21h}, playlist_pop_hits),
    ({(1w or 2w or 3w or 4w) and 21h-24h}, playlist_ultimo_volume),
    ({(5w or 6w) and 21h-24h}, playlist_gospel_club)
  ]
)

radio = fallback(
  id="gh_grade_com_rotacao_geral_test",
  track_sensitive=true,
  [gh_grade_semanal, radio]
)
ignore(radio)
