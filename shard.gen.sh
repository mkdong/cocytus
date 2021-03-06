
>&2 echo -n "nshard=" && read nshard
>&2 echo -n "nparity=" && read nparity
>&2 echo -n "ngroup=" && read ngroup

nnode=$((nshard+nparity))
>&2 echo "nnode=$nnode"

for ((i=0; i<$nnode; i++)); do
    >&2 echo -n "ip for node #$i: " && read ip
    ips[$i]=$ip
done

echo "##### shard config file generated by shard.gen.sh #####"
echo "# config file"
echo "#"
echo "# nnode"
echo "$nnode"
echo "# nshard"
echo "$nshard"
echo "# nparity"
echo "$nparity"
echo "# ngroup"
echo "$ngroup"

echo ""
echo "# group details"
echo "# nid -> node id"
echo "# gid -> group id"
echo "# lid -> local id (shard id / pairty id)"
echo "# nid gid lid ip port"
for ((gid=0; gid<$ngroup; gid++)); do
    for ((lid=0; lid<$nnode; lid++)); do
        nid=$(((lid+gid)%nnode))
        echo -n "$nid $gid $lid ${ips[nid]}"
        printf " 5%02d%d\n" $gid $lid
    done
    echo ""
done
