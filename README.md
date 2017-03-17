# zabbix-smartctl

S.M.A.R.T. を使用してZabbixでディスクを監視するためのファイル群です。



## 動作環境


### OS

* CentOS 7
    * 他のOSでも動くと思います。


### ソフトウェア

* Zabbix (>= 3.0?)
* smartmontools



## インストール

1. 必要なソフトウェアをインストールします。
  ```console
  [root@localhost ~]# yum install smartmontools
  ```

2. zabbix-smartctlを適当な場所にダウンロード・展開します。以下、 `/usr/local/src` に展開したとします。

3. 設定ファイル・スクリプトを指定箇所にコピーします。
  ```console
  [root@localhost ~]# cp -a /usr/local/src/zabbix-smartctl/sbin/smartctl-discovery.sh /usr/local/sbin/
  [root@localhost ~]# chown root:root /usr/local/sbin/smartctl-discovery.sh
  [root@localhost ~]# chmod 700 /usr/local/sbin/smartctl-discovery.sh
  [root@localhost ~]# cp -a /usr/local/src/zabbix-smartctl/etc/zabbix/zabbix_agentd.d/userparameter_smartctl.conf /etc/zabbix/zabbix_agentd.d/
  [root@localhost ~]# chown root:root /etc/zabbix/zabbix_agentd.d/userparameter_smartctl.conf
  [root@localhost ~]# chmod 644 /etc/zabbix/zabbix_agentd.d/userparameter_smartctl.conf
  [root@localhost ~]# cp -a /usr/local/src/zabbix-smartctl/etc/sudoers.d/zabbix /etc/sudoers.d/
  [root@localhost ~]# visudo    # 何も編集せずにExitする
  ```

4. Zabbix Agentを再起動します。
  ```console
  [root@localhost ~]# systemctl restart zabbix-agent.service
  ```

5. `/usr/local/src/zabbix-smartctl/etc/zabbix/templates/zbx_export_templates_3.0.xml` をZabbix Webから読み込ませ、テンプレートを作成します。

6. 作成したテンプレートを、監視が必要なホストに読み込ませてください。



## 更新履歴

[CHANGELOG](CHANGELOG.md) をご参照ください。

