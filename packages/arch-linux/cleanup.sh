for file in *
do
    if [ -f "$file" ] && [ "$file" != "PKGBUILD" ] && [ "$file" != "cleanup.sh" ]
    then
        rm "$file"
    fi
done
