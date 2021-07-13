function Read-DefaultTokenName {
    # This function is ran when the token name has not been specified which will prompt user for specification
    if(("" -eq $Global:name) -or ($null -eq $Global:name)){
        if($null -eq $Global:name){
            $Global:name = (Read-Host -Prompt "A default token name was not specified. Please enter the token name: ")
        }else{
            if($name -ne $Global:name){
                $Global:name = (Read-Host -Prompt "A default token name was not specified. Please enter the token name: ")
            }else{
                return (Read-Host -Prompt "A default token name was not specified. Please enter the token name: ")
            }
        }
    }else{ return $name }
}