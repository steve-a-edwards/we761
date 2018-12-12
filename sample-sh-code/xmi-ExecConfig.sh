#########################################################################################
#  Description: LINUX SCRIPT TO CALL XMI ExecConfig which runs a CLI script on the DataPower.
#     Run as follows from appropriate folder:
#          ./xmi-ExecConfig-backup-scp.sh
#     See bottom of this file for ensuring correct Unix execution permissions.
#     This XMI call to a DataPower triggers the running of an exec file consisting of CLI instructions.
#  Author: Steve Edwards
#  Date:   12/12/2018
#  Change values in  6 variables belwo as appropriate.

domain="Admin-Utils"
exec_file="local:///scripts/import-export-utils/backup-scp.cfg"
dp_host="192.168.0.100"
dp_xmi_port="5550"
user="sysadmin"
password="irlpsysadmin"

xmi_string="<S:Envelope xmlns:S='http://schemas.xmlsoap.org/soap/envelope/'>
				<S:Body>
					<dp:request xmlns:dp='http://www.datapower.com/schemas/management'
								domain='${domain}'>
							<dp:do-action>
								<ExecConfig>
									<URL>${exec_file}</URL>
								</ExecConfig>
							</dp:do-action>
						</dp:request>
				</S:Body>
			</S:Envelope>"

echo "Domain        : ${domain}"
echo "Exec file     : ${exec_file}"
echo "DataPower host: ${dp_host}"
echo "DataPower port: ${dp_xmi_port}"
echo "User          : ${user}"
echo "Password      : ${password}"

echo "Outgoing XMI message:"
echo $xmi_string

echo "Wait for a few seconds for response ..."

curl -s --data-binary "${xmi_string}" https://$dp_host:$dp_xmi_port/service/mgmt/current -u $user:$password -k

# Ensure UNIX executable permissions in advance of running this shell script:
# chmod a+x xmi-ExecConfig-backup-scp.sh
