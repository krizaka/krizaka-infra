# krizaka.com: 27 records, imported as they are at Porkbun (2026-10-25). Order: apps, mail, verification, ACME, nameservers.
locals {
  krizaka_com = {
    # apps and sites
    "apex-alias"   = { name = "@", type = "ALIAS", value = "krizaka-com-xfzbi.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "krizaka.com serves the krizaka-com app (App Platform)" }
    "blog-cname"   = { name = "blog", type = "CNAME", value = "krizaka-blog-krdbv.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "blog.krizaka.com serves the krizaka-blog app (App Platform)" }
    "java-cname"   = { name = "java", type = "CNAME", value = "krizaka-com-xfzbi.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "java.krizaka.com serves the krizaka-com app (static_sites component) (App Platform)" }
    "motion-cname" = { name = "motion", type = "CNAME", value = "krizaka.github.io", ttl = 600, prio = 0, kind = "app", purpose = "motion.krizaka.com serves the krizaka-motion site (GitHub Pages)" }
    "ts-cname"     = { name = "ts", type = "CNAME", value = "krizaka-com-xfzbi.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "ts.krizaka.com serves the krizaka-com app (static_sites component) (App Platform)" }
    "ui-cname"     = { name = "ui", type = "CNAME", value = "krizaka-com-xfzbi.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "ui.krizaka.com serves the krizaka-com app (static_sites component) (App Platform)" }
    "www-cname"    = { name = "www", type = "CNAME", value = "krizaka-com-xfzbi.ondigitalocean.app", ttl = 600, prio = 0, kind = "app", purpose = "www.krizaka.com serves the krizaka-com app (App Platform)" }
    # MAIL (Mailgun, Resend, DKIM, SPF, DMARC, forwarding): do not touch without a mail test
    "apex-mx-1"                 = { name = "@", type = "MX", value = "fwd1.porkbun.com", ttl = 600, prio = 10, kind = "mail", purpose = "Porkbun email forwarding for krizaka.com (MX, priority 10)" }
    "apex-mx-2"                 = { name = "@", type = "MX", value = "fwd2.porkbun.com", ttl = 600, prio = 20, kind = "mail", purpose = "Porkbun email forwarding for krizaka.com (MX, priority 20)" }
    "apex-txt-1"                = { name = "@", type = "TXT", value = "v=spf1 include:_spf.porkbun.com ~all", ttl = 600, kind = "mail", purpose = "SPF for Porkbun email forwarding of krizaka.com" }
    "dmarc-txt"                 = { name = "_dmarc", type = "TXT", value = "v=DMARC1; p=none; adkim=r; aspf=r", ttl = 600, prio = 0, kind = "mail", purpose = "DMARC policy of krizaka.com (reports only, p=none)" }
    "dmarc-mg-txt"              = { name = "_dmarc.mg", type = "TXT", value = "v=DMARC1; p=none; pct=100; fo=1; ri=3600; rua=mailto:295a1141@dmarc.mailgun.org,mailto:xwltagrguk7@inbox.ondmarc.com; ruf=mailto:295a1141@dmarc.mailgun.org,mailto:xwltagrguk7@inbox.ondmarc.com;", ttl = 300, prio = 0, kind = "mail", purpose = "DMARC policy of mg.krizaka.com (reports only, p=none)", managed = false }
    "dmarc-www-txt"             = { name = "_dmarc.www", type = "TXT", value = "v=DMARC1; p=none; pct=100; fo=1; ri=3600; rua=mailto:295a1141@dmarc.mailgun.org,mailto:xwltagrguk7@inbox.ondmarc.com; ruf=mailto:295a1141@dmarc.mailgun.org,mailto:xwltagrguk7@inbox.ondmarc.com;", ttl = 300, prio = 0, kind = "mail", purpose = "DMARC policy of www.krizaka.com (reports only, p=none)", managed = false }
    "email-mg-cname"            = { name = "email.mg", type = "CNAME", value = "mailgun.org", ttl = 300, prio = 0, kind = "mail", purpose = "Mailgun sending/tracking domain email.mg.krizaka.com", managed = false }
    "mailo--domainkey-mg-txt"   = { name = "mailo._domainkey.mg", type = "TXT", value = "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDM7ArT/mjkRkYZLecPhreFCyOOd1DnWEBinPNurDcWeEiEI3ItceWyrAShPTUYOJ1VJepR9wIbCn9RNg1H5CeYNK+bxJWTMeQrZ67y0u3SUCIYthsKsHeZniFhMyvwUmW83J3edKCm6feRem4enaae83/J7zfVTlTazjsHOiXARwIDAQAB", ttl = 300, prio = 0, kind = "mail", purpose = "DKIM public key (Mailgun) for mg.krizaka.com", managed = false }
    "mg-txt"                    = { name = "mg", type = "TXT", value = "v=spf1 include:mailgun.org ~all", ttl = 300, prio = 0, kind = "mail", purpose = "SPF for Mailgun sending from mg.krizaka.com", managed = false }
    "pdk1--domainkey-www-cname" = { name = "pdk1._domainkey.www", type = "CNAME", value = "pdk1._domainkey.43039b.dkim6.us.mgsend.org", ttl = 300, prio = 0, kind = "mail", purpose = "DKIM key (Mailgun) for www.krizaka.com", managed = false }
    "pdk2--domainkey-www-cname" = { name = "pdk2._domainkey.www", type = "CNAME", value = "pdk2._domainkey.43039b.dkim6.us.mgsend.org", ttl = 300, prio = 0, kind = "mail", purpose = "DKIM key (Mailgun) for www.krizaka.com", managed = false }
    # VERIFICATION (search engines, GitHub, Maven Central): keep, the owner proves the domain with them
    "apex-txt-2"       = { name = "@", type = "TXT", value = "26clpfqsfz", ttl = 600, prio = 0, kind = "verification", purpose = "Maven Central namespace verification (com.krizaka)" }
    "apex-txt-3"       = { name = "@", type = "TXT", value = "google-site-verification=rvcKF4Om7WTTrNXAOqLMi9ZnnpdoH0BwZU0d_wMEpSw", ttl = 600, prio = 0, kind = "verification", purpose = "Google Search Console ownership of krizaka.com" }
    "gh-krizaka-o-txt" = { name = "_gh-krizaka-o", type = "TXT", value = "3f81386051", ttl = 600, prio = 0, kind = "verification", purpose = "GitHub organization domain verification (krizaka)" }
    # ACME challenges (certificates): kept as they are
    "acme-challenge-txt-1" = { name = "_acme-challenge", type = "TXT", value = "P3OtT5phFau2eHaapQ_tEBIO72_ppSJRemrKObFHGPc", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of krizaka.com (certificate issuance), kept as is" }
    "acme-challenge-txt-2" = { name = "_acme-challenge", type = "TXT", value = "fe_qfKyIbYkZ2tyqi40FknjbQ9tAuGOJZJ0nAU58rT4", ttl = 600, kind = "acme", purpose = "ACME DNS-01 challenge of krizaka.com (certificate issuance), kept as is" }
    # NAMESERVERS (Porkbun defaults)
    "apex-ns-1" = { name = "@", type = "NS", value = "curitiba.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-2" = { name = "@", type = "NS", value = "fortaleza.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-3" = { name = "@", type = "NS", value = "maceio.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
    "apex-ns-4" = { name = "@", type = "NS", value = "salvador.porkbun.com", ttl = 86400, kind = "nameserver", purpose = "Porkbun default nameserver of the zone" }
  }
}
