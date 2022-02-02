for sub in `az account list --all | jq -r .[].name` ; do
  az account set --name "$sub"
  for wafid in `az network application-gateway list | jq -r .[].id` ; do
    mode=`az network application-gateway waf-config show --ids $wafid | jq -r .firewallMode`
    shortwafname=`echo $wafid | cut -f 9 -d /`
    echo "$sub,$shortwafname,$mode"
  done
done
