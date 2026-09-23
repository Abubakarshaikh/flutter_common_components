enum PhoneNumber {
  french('FR', '+33', '🇫🇷 FR', '# ## ## ## ##', '6 00 00 00 00', 9),
  germany('DE', '+49', '🇩🇪 DE', '#### #######', '1512 3456789', 11),
  liban('LB', '+961', '🇱🇧 LB', '## ### ###', '71 000 000', 8),
  unitedArabEmirates('AE', '+971', '🇦🇪 AE', '## ### ####', '50 123 4567', 9),
  qatar('QA', '+971', '🇦🇪 QA', '### ####', '669 1923', 7),
  belgium('BE', '+32', '🇧🇪 BE', '### ## ## ##', '475 87 19 02', 9),
  italy('IT', '+39', '🇮🇹 IT', '### ### ####', '312 345 1902', 10),
  spain('ES', '+34', '🇪🇸 ES', '### ### ###', '612 345 678', 9),
  irland('IE', '+353', '🇮🇪 IE', '## ### ####', '85 123 4567', 9),
  norvege('NO', '+47', '🇳🇴 NO', '### ## ###', '412 34 567', 8),

  swiss('CH', '+41', '🇨🇭 CH', '## ### ## ####', '75 123 45 6789', 11),
  austria('AT', '+43', '🇦🇹 AT', '### ### ## ##', '664 123 45 67', 10),
  netherlands('NL', '+31', '🇳🇱 NL', '## ### ## ##', '97 010 52 02', 9),
  sweden('SE', '+46', '🇸🇪 SE', '# ### ### ##', '1 234 567 89', 9),
  monaco('MC', '+377', '🇲🇨 MC', '## ## ## ##', '12 34 56 78', 8),
  martinique('MQ', '+596', '🇲🇶 MQ', '### ## ## ##', '596 12 34 56', 9),
  guyane('GF', '+594', '🇬🇫 GF', '### ## ## ##', '594 12 34 56', 9),
  guadeloupe('GP', '+590', '🇬🇵 GP', '### ## ## ##', '590 12 34 56', 9),
  mayotte('YT', '+262', '🇾🇹 YT', '### ## ## ##', '262 12 34 56', 9),
  reunion('RE', '+262', '🇷🇪 RE', '### ## ## ##', '262 12 34 56', 9),
  maroc('MA', '+212', '🇲🇦 MA', '# ## ## ## ##', '6 12 34 56 78', 9),
  danemark('DK', '+45', '🇩🇰 DK', '## ## ## ##', '12 34 56 78', 8),
  malte('MT', '+356', '🇲🇹 MT', '## ### ###', '99 123 456', 11),
  finlande('FI', '+358', '🇫🇮 FI', '## ### ####', '40 123 4567', 9),
  unitedStates('US', '+1', '🇺🇸 US', '### ### ####', '201-234-5678', 10),
  saintBarthelemy('BL', '+590', '🇧🇱 BL', '### ## ## ##', '590 12 34 56', 9),
  saintMartin('MF', '+590', '🇫🇷 MF', '### ## ## ##', '590 12 34 56', 9),
  newCaledonia('NC', '+687', '🇳🇨 NC', '## ## ##', '75 12 34', 6),
  frenchPolynesia('PF', '+689', '🇵🇫 PF', '## ## ##', '87 12 34 56', 8),
  wallisAndFutuna('WF', '+681', '🇼🇫 WF', '## ## ##', '50 12 34', 6),
  saintPierreAndMiquelon('PM', '+508', '🇵🇲 PM', '## ## ##', '55 12 34', 6);

  const PhoneNumber(
    this.countryCode,
    this.phoneCode,
    this.label,
    this.mask,
    this.hintText,
    this.length,
  );
  final String countryCode;
  final String phoneCode;
  final String label;
  final String mask;
  final String hintText;
  final int length;
}
