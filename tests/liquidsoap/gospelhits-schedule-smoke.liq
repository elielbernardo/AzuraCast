# Smoke test of the exact versioned Gospel Hits schedule.
# blank() sources prevent audio playback and external station dependencies.

playlist_super_sequencia = blank()
playlist_classic_hits = blank()
playlist_gospel_beats = blank()
playlist_conexao_hits = blank()
playlist_hits_brasil = blank()
playlist_gospel_rock = blank()
playlist_pop_hits = blank()
playlist_ultimo_volume = blank()
playlist_gospel_club = blank()

playlist_compartilhado___comerciais___saida_de_bloco = blank()
playlist_compartilhado___comerciais___anuncios = blank()
playlist_compartilhado___comerciais___vhts_entre_comerciais = blank()
playlist_compartilhado___comerciais___volta_de_bloco = blank()

radio = blank()

%include "/schedule/gospelhits_schedule.liq"

ignore(radio)
