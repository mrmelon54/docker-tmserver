#!/command/with-contenv bash

config=( )
playlist=( )

# Mandatory
SERVER_SA_PASSWORD=${SERVER_SA_PASSWORD:?ERROR | SuperAdminPassword needs to be set. Generate with pwgen if needed.} && \
    config+=( "SERVER_SA_PASSWORD" )
SERVER_ADM_PASSWORD=${SERVER_ADM_PASSWORD:?ERROR | AdminPassword needs to be set. Generate with pwgen if needed.} && \
    config+=( "SERVER_ADM_PASSWORD" )
SERVER_LOGIN=${SERVER_LOGIN?:ERROR | ServerLogin is missing. Server cannot start.} && \
    config+=( "SERVER_LOGIN" )
SERVER_LOGIN_PASSWORD=${SERVER_LOGIN_PASSWORD?:ERROR | ServerLoginPassword is missing. Server cannot start.} && \
    config+=( "SERVER_LOGIN_PASSWORD" )

# Optional
SERVER_PORT=${SERVER_PORT:-2350} && config+=( "SERVER_PORT" )
echo "INFO | SERVER_PORT: ${SERVER_PORT}"
SERVER_P2P_PORT=${SERVER_P2P_PORT:-3450} && config+=( "SERVER_P2P_PORT" )
echo "INFO | SERVER_P2P_PORT: ${SERVER_P2P_PORT}"
SERVER_NAME=${SERVER_NAME:-Trackmania Server} && config+=( "SERVER_NAME" )
echo "INFO | SERVER_NAME: ${SERVER_NAME}"
SERVER_COMMENT=${SERVER_COMMENT:-This is a Trackmania Server} && config+=( "SERVER_COMMENT" )
echo "INFO | SERVER_COMMENT: ${SERVER_COMMENT}"
SERVER_PASSWORD=${SERVER_PASSWORD} && config+=( "SERVER_PASSWORD" )
echo "INFO | SERVER_PASSWORD: ${SERVER_PASSWORD}"
HIDE_SERVER=${HIDE_SERVER:-0} && config+=( "HIDE_SERVER" )
echo "INFO | HIDE_SERVER: ${HIDE_SERVER}"
MAX_PLAYERS=${MAX_PLAYERS:-32} && config+=( "MAX_PLAYERS" )
echo "INFO | MAX_PLAYERS: ${MAX_PLAYERS}"

# Game Config
GAMEMODE=${GAMEMODE:-1} && playlist+=( "GAMEMODE" )
echo "INFO | GAMEMODE: ${GAMEMODE} | 1 = TimeAttack"
CHATTIME=${CHATTIME:-10000} && playlist+=( "CHATTIME" )
echo "INFO | CHATTTIME: ${CHATTIME} ms"
FINISHTIMEOUT=${FINISHTIMEOUT:-1} && playlist+=( "FINISHTIMEOUT" )
echo "INFO | FINISHTIMEOUT: ${FINISHTIMEOUT}"
DISABLERESPAWN=${DISABLERESPAWN:-0} && playlist+=( "DISABLERESPAWN" )
echo "INFO | DISABLERESPAWN: ${DISABLERESPAWN}"
ROUNDS_POINTSLIMIT=${ROUNDS_POINTSLIMIT:-30} && playlist+=( "ROUNDS_POINTSLIMIT" )
echo "INFO | ROUNDS_POINTSLIMIT: ${ROUNDS_POINTSLIMIT}"
TIMEATTACK_LIMIT=${TIMEATTACK_LIMIT:-180000} && playlist+=( "TIMEATTACK_LIMIT" )
echo "INFO | TIMEATTACK_LIMIT: ${TIMEATTACK_LIMIT} ms"
TEAM_POINTSLIMIT=${TEAM_POINTSLIMIT:-50} && playlist+=( "TEAM_POINTSLIMIT" )
echo "INFO | TEAM_POINTSLIMIT: ${TEAM_POINTSLIMIT}"
TEAM_MAXPOINTS=${TEAM_MAXPOINTS:-6} && playlist+=( "TEAM_MAXPOINTS" )
echo "INFO | TEAM_MAXPOINTS: ${TEAM_MAXPOINTS}"
LAPS_NBLAPS=${LAPS_NBLAPS:-5} && playlist+=( "LAPS_NBLAPS" )
echo "INFO | LAPS_NBLAPS: ${LAPS_NBLAPS}"
LAPS_TIMELIMIT=${LAPS_TIMELIMIT:-0} && playlist+=( "LAPS_TIMELIMIT" )
echo "INFO | LAPS_TIMELIMIT: ${LAPS_TIMELIMIT}"
CUP_POINTSLIMIT=${CUP_POINTSLIMIT:-100} && playlist+=( "CUP_POINTSLIMIT" )
echo "INFO | CUP_POINTSLIMIT: ${CUP_POINTSLIMIT}"
CUP_ROUNDSPERCHALLENGE=${CUP_ROUNDSPERCHALLENGE:-5} && playlist+=( "CUP_ROUNDSPERCHALLENGE" )
echo "INFO | CUP_ROUNDSPERCHALLENGE: ${CUP_ROUNDSPERCHALLENGE}"
CUP_NBWINNERS=${CUP_NBWINNERS:-3} && playlist+=( "CUP_NBWINNERS" )
echo "INFO | CUP_NBWINNERS: ${CUP_NBWINNERS}"
CUP_WARMUPDURATION=${CUP_WARMUPDURATION:-2} && playlist+=( "CUP_WARMUPDURATION" )
echo "INFO | CUP_WARMUPDURATION: ${CUP_WARMUPDURATION}"

# Parse config.xml
for idx in "${!config[@]}"; do
    arg=${config[$idx]}
    sed -i -e "s/@$arg@/${!arg}/g" GameData/Config/config.xml
done

# Parse playlist.xml
for idx in "${!playlist[@]}"; do
    arg=${playlist[$idx]}
    sed -i -e "s/@$arg@/${!arg}/g" GameData/Tracks/MatchSettings/playlist.xml
done