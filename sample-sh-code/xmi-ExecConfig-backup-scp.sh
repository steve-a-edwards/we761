#########################################################################################
#  Description: SCRIPT TO CALL XMI ExecConfig which runs a CLI script on the DataPower.
#     Run as follows from appropriate folder:
#         ./deploy_using_properties.sh
#     See bottom of this file for ensuring correct Unix execution permissions.
#     Provides property-based approach to feeding variable values to deployment scripts.
#  Author: Steve Edwards
#  Date:   12/12/2018

domain="Admin-Utils"
exec_file="local:///scripts/import-export-utils/backup-scp.cfg"
#dp_host="192.168.0.100"
dp_host="192.168.1.75"
dp_xmi_port="5550"
user="admin"
password="web1sphere"

xmi_string="<S:Envelope xmlns:S='http://schemas.xmlsoap.org/soap/envelope/'>\
				<S:Body>\
					<dp:request xmlns:dp='http://www.datapower.com/schemas/management'\
								domain='${domain}'>\
							<dp:do-action>\
								<ExecConfig>\
									<URL>${exec_file}</URL>\
								</ExecConfig>\
							</dp:do-action>\
						</dp:request>\
				</S:Body>\
			</S:Envelope>"

echo $domain
echo $exec_file
echo $dp_host
echo $dp_xmi_port
echo $user
echo $password

echo $xmi_string

curl -s --data-binary "${xmi_string}" https://$dp_host:$dp_xmi_port/service/mgmt/current -u $user:$password -k

#curl --data-binary "${xmi_string}" https://192.168.1.75:5550/service/mgmt/current -u admin:web1sphere -k


#

# Ensure UNIX executable permissions in advance of running this shell script:
# chmod a+x xmi-ExecConfig-backup-scp.sh
