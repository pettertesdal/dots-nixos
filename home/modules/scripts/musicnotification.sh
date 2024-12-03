#!/etc/profiles/per-user/tesdap/bin/bash
readonly MUSIC_DIR="$HOME/media/music/"
readonly SONG_PATH="$(mpc --format '%file%' current)"
readonly SONG_DIR="$(dirname "${SONG_PATH}")"
readonly ALBUM_ART_PATH="${MUSIC_DIR}/${SONG_DIR}/Cover.jpg"

# if [[ ! -f "${ALBUM_ART_PATH}" ]]; then # file doesn't exist
# 	ALBUM_ART_PATH="" # TODO: insert path to generic icon here
# fi

notify-send -i "${ALBUM_ART_PATH}" "Now Playing" "$(mpc --format '%title% - %artist%' current)"
