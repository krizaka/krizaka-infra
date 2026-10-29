# What runs today at Porkbun, imported into this stack's state (AGENTS.md « Import before change »).
# `<domain>:<record id>`; the ids are not secrets. `tofu plan` imports them in the plan only.
import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-alias"]
  id = "krizaka.com:551816370"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["blog-cname"]
  id = "krizaka.com:594888777"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["java-cname"]
  id = "krizaka.com:594387015"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["lab-cname"]
  id = "krizaka.com:598946764"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["ts-cname"]
  id = "krizaka.com:597127514"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["ui-cname"]
  id = "krizaka.com:594397942"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["www-cname"]
  id = "krizaka.com:591607191"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "krizaka.com:597087325"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "krizaka.com:597087330"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "krizaka.com:597087336"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "krizaka.com:596353040"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "krizaka.com:592336665"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-txt-3"]
  id = "krizaka.com:596355405"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["gh-krizaka-o-txt"]
  id = "krizaka.com:596356986"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "krizaka.com:597248720"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "krizaka.com:597248718"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "krizaka.com:551816361"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "krizaka.com:551816360"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "krizaka.com:551816358"
}

import {
  to = module.dns_porkbun["krizaka.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "krizaka.com:551816359"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-alias"]
  id = "orazaka.com:596640594"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["admin-cname"]
  id = "orazaka.com:594366214"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["broker-dev-a"]
  id = "orazaka.com:594427139"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["dev-cname"]
  id = "orazaka.com:594318496"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["www-cname"]
  id = "orazaka.com:596640589"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "orazaka.com:591862596"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "orazaka.com:591862597"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "orazaka.com:591862598"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "orazaka.com:596353048"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "orazaka.com:596355414"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "orazaka.com:591862772"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "orazaka.com:591862787"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "orazaka.com:591862595"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "orazaka.com:591862594"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "orazaka.com:591862592"
}

import {
  to = module.dns_porkbun["orazaka.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "orazaka.com:591862593"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-alias"]
  id = "yomizaka.com:596621902"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["admin-cname"]
  id = "yomizaka.com:594527374"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["dev-cname"]
  id = "yomizaka.com:594500509"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["www-cname"]
  id = "yomizaka.com:596621889"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "yomizaka.com:594465256"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "yomizaka.com:594465257"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-txt-1"]
  id = "yomizaka.com:594465258"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["dmarc-txt"]
  id = "yomizaka.com:596353082"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-txt-2"]
  id = "yomizaka.com:596355459"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "yomizaka.com:594465379"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "yomizaka.com:594465376"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "yomizaka.com:594465255"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "yomizaka.com:594465254"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "yomizaka.com:594465252"
}

import {
  to = module.dns_porkbun["yomizaka.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "yomizaka.com:594465253"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-alias"]
  id = "akinaza.com:596619430"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["wildcard-cname"]
  id = "akinaza.com:597052805"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["admin-cname"]
  id = "akinaza.com:594810894"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["dev-cname"]
  id = "akinaza.com:594800325"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["www-cname"]
  id = "akinaza.com:596619424"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-mx-1"]
  id = "akinaza.com:594550444"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-mx-2"]
  id = "akinaza.com:594550445"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-txt"]
  id = "akinaza.com:594550446"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["acme-challenge-txt-1"]
  id = "akinaza.com:597052812"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["acme-challenge-txt-2"]
  id = "akinaza.com:594553095"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["acme-challenge-txt-3"]
  id = "akinaza.com:594553104"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-1"]
  id = "akinaza.com:594550443"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-2"]
  id = "akinaza.com:594550442"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-3"]
  id = "akinaza.com:594550440"
}

import {
  to = module.dns_porkbun["akinaza.com"].porkbun_dns_record.this["apex-ns-4"]
  id = "akinaza.com:594550441"
}
