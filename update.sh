#!/bin/bash
set -eo pipefail

variants=(
	debian
)

min_version='1.1'


# version_greater_or_equal A B returns whether A >= B
function version_greater_or_equal() {
	[[ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" || "$1" == "$2" ]];
}

dockerRepo="monogramm/docker-openldap"
# Retrieve automatically the latest versions
latests=( $( curl -fsSL 'https://api.github.com/repos/osixia/docker-openldap/tags' |tac|tac| \
	grep -oE '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | \
	sort -urV ) )

# Remove existing images
echo "reset docker images"
find ./images -maxdepth 1 -type d -regextype sed -regex '\./images/[[:digit:]]\+\.[[:digit:]]\+' -exec rm -r '{}' \;

mkdir -p images
rm -rf images/*

echo "update docker images"
travisEnv=
for latest in "${latests[@]}"; do
	version=$(echo "$latest" | cut -d. -f1-2)

	# Only add versions >= "$min_version"
	if version_greater_or_equal "$version" "$min_version"; then

		for variant in "${variants[@]}"; do
			# Create the version directory with a Dockerfile.
			dir="images/$version-$variant"
			if [ -d "$dir" ]; then
				continue
			fi
			echo "generating $latest [$version-$variant]"
			mkdir -p "$dir"

			template="Dockerfile.$variant"
			cp "template/$template" "$dir/Dockerfile"

			cp -r "template/bootstrap/" "$dir/"
			cp -r "template/hooks/" "$dir/"

			# Replace the variables.
			sed -ri -e '
				s/%%VARIANT%%/-'"$variant"'/g;
				s/%%VERSION%%/'"$latest"'/g;
			' "$dir/Dockerfile"

			travisEnv='\n    - VERSION='"$version"' VARIANT='"$variant$travisEnv"

			if [[ "$1" == 'build' ]]; then
				tag="$version-$variant"
				echo "Build Dockerfile for ${tag}"
				docker build -t "${dockerRepo}:${tag}" "$dir"
			fi
		done
	fi

done

# update .travis.yml
travis="$(awk -v 'RS=\n\n' '$1 == "env:" && $2 == "#" && $3 == "Environments" { $0 = "env: # Environments'"$travisEnv"'" } { printf "%s%s", $0, RS }' .travis.yml)"
echo "$travis" > .travis.yml
