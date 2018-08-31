#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

if [ -z ${YC_PY_VER} ]; then
    YC_PY_VER="2.7"
fi
PYTHON_CALLABLE="python${YC_PY_VER}"

ROBOT_ARGS=""

function usage()
{
    echo "Usage ./run-all-tests.sh options"
    echo ""
    echo "OPTIONS:"
    echo "  -c              Select connection: <subdomain(default)/domain/embed/host>"
    echo "  -d <driver>     Select driver: <chrome(default)/firefox/chrome_headless/firefox_headless/edge/ie/bs_edge>"
    echo "  -h              Show this message"
    echo "  -k              BrowserStack user key (bs_<driver> ONLY)"
    echo "  -l              Run tests on local server"
    echo "  -m              Add metadata to test report. The argument must be in the format name:value, underscore -> space"
    echo "  -u              BrowserStack user (bs_<driver> ONLY)"
    echo "  -v              Browser version to use (bs_<driver> ONLY)"
    echo "  -w              Output fixture application mapping debug info"
    echo "  -x \"<args>\"   Extra arguments to pass to robot"
    echo
    exit
}

while getopts ":c:d:hk:lm:u:v:wx:" opt; do
    case ${opt} in
        c)  ROBOT_ARGS+=" --variable CON_TYPE:${OPTARG}"
            ROBOT_ARGS+=" --metadata Connection_type:${OPTARG}"
            ;;
        d)  ROBOT_ARGS+=" --variable DRIVER_TYPE:${OPTARG}"
            ROBOT_ARGS+=" --metadata Driver_type:${OPTARG}"
            ;;
        h)  usage
            ;;
        k)  ROBOT_ARGS+=" --variable BS_KEY:${OPTARG}"
            ;;
        l)  ROBOT_ARGS+=" --variable HOST:https://devel.yescourse.net"
            ROBOT_ARGS+=" --metadata Host:https://devel.yescourse.net"
            ;;
        m)  ROBOT_ARGS+=" --metadata ${OPTARG}"
            ;;
        u)  ROBOT_ARGS+=" --variable BS_USER:${OPTARG}"
            ;;
        v)  ROBOT_ARGS+=" --variable BROWSER_VERSION:${OPTARG}"
            ROBOT_ARGS+=" --metadata Browser_version:${OPTARG}"
            ;;
        w)  ROBOT_ARGS+=" --variable FIXTURE_DEBUG:True"
            ;;
        x)  ROBOT_ARGS+=" ${OPTARG}"
            ;;
    esac
done

# run the tests
# run within the reports dir as robot will log to current dir by default
cd ${SCRIPT_DIR}/reports

# run all tests
${PYTHON_CALLABLE} -m robot ${ROBOT_ARGS} ../tests/

# format the results
# ${PYTHON_CALLABLE} -m robot.rebot output.xml
