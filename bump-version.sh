#!/usr/bin/env bash

TARGETS=(Chart.yaml)
BUMP_TYPE="patch"

usage() {
    cat <<EOF
Usage: $0 [OPTION...] CHART

CHART can be chart name or path to chart root

Options:
    -t          type of version to bump,
                one of major,minor,patch. (default: patch)
    -d          dry run

    -h          print this help message
EOF
}

if [ $# == 0 ]; then
    usage
    exit 0
fi

args=()
while [ $OPTIND -le "$#" ]; do
    if getopts t:dh opt; then
        case $opt in
        t)
            case "$OPTARG" in
            major | minor | patch)
                BUMP_TYPE="$OPTARG"
                ;;
            *)
                echo "type can only be one of major|minor|patch, not '$opt'"
                exit 1
                ;;
            esac
            ;;
        d) dryrun='true';;
        ? | h)
            usage
            exit 0
            ;;
        esac
    else
        args+=("${!OPTIND}")
        ((OPTIND++))
    fi
done
CHART=${args[@]:0:1}

[ -f "charts/$CHART/Chart.yaml" ] && chartyaml="charts/$CHART/Chart.yaml"
[ -f "$CHART/Chart.yaml" ] && chartyaml="$CHART/Chart.yaml"
if [[ -f $chartyaml ]]; then
    current=$(cat $chartyaml | grep -oP '^version:\s*v?\K\d+\.\d+\.\d+')
    if [[ ! -z $current ]]; then
        IFS=. read -r major minor patch <<<$current
        case $BUMP_TYPE in
        major)
            new="$((major + 1)).0.0"
            ;;
        minor)
            new="$major.$((minor + 1)).0"
            ;;
        patch)
            new="$major.$minor.$((patch + 1))"
            ;;
        esac
        echo "bumping $BUMP_TYPE version of chart '$CHART': ${current} -> ${new}"
    fi
else
    echo "chart '$CHART' not found"
    exit 1
fi

dir=$(dirname $chartyaml)
for f in ${TARGETS[@]}; do
    if [ -f $dir/$f ]; then
        echo "processing file $dir/$f"
        [[ "$dryrun" ]] && continue;
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s|$current|$new|g" "$dir/$f"
        else
            sed -i "s|$current|$new|g" "$dir/$f"
        fi
    fi
done

echo 'done'
