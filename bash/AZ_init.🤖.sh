

#* θΏε£ (JΓ¬nkΗu) π *ALWAYS* load c0re Libraries!
if [ ! -x "./bash/c0re.π.sh" ] ; then
    echo "missing ./bash/c0re.π.sh" && exit 
else
    source "./bash/c0re.π.sh" 
fi

az account set -s NAME_OR_ID

az local-context 

# ζδΉζ · Get
AZURE_VALID_REGIONS=`$AZ_CLI account list-locations --query '[].[name]' --output table`


