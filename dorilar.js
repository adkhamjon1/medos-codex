window.Medos = window.Medos || {};

window.Medos.drugs = [
  {
    id: "amoksitsillin",
    name: "Amoksitsillin",
    form: "suspenziya",
    strength: "250 mg / 5 mL",
    doseRule: "20-40 mg/kg/kun",
    maxDose: "1 000 mg/kun",
    dosing: {
      unit: "mg",
      perKgMin: 20,
      perKgMax: 40,
      maxDailyDoseMg: 1000,
      frequencyPerDay: 3,
      minAgeYears: 1
    },
    ageLimits: "1 yoshdan katta",
    notes: "Yengil va o'rtacha respirator infeksiyalarda qo'llanadi."
  },
  {
    id: "setirizin",
    name: "Setirizin",
    form: "tabletka",
    strength: "10 mg",
    doseRule: "0.25 mg/kg/kun",
    maxDose: "10 mg/kun",
    dosing: {
      unit: "mg",
      perKgMin: 0.25,
      perKgMax: 0.25,
      maxDailyDoseMg: 10,
      frequencyPerDay: 1,
      minAgeYears: 2
    },
    ageLimits: "2 yoshdan katta",
    notes: "Allergik rinit va qichishishda simptomatik yordam."
  }
];
