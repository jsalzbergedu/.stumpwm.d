for file in .* *
do
    if [ -f "$file" ] || [ -d "$file" ]
    then
        if [ "$file" != "PKGBUILD" ] && [ "$file" != "cleanup.sh" ] && [ "$file" != "." ] && [ "$file" != ".." ]
        then
            rm -rf "$file"
        fi
    fi
done
