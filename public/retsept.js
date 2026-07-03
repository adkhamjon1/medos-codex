window.Medos = window.Medos || {};

window.Medos.prescription = {
  build({ patient, diagnosis, drug, weight, age }) {
    const lines = [
      `Bemor: ${patient || "kiritilmagan"}`,
      `Tashxis: ${diagnosis ? diagnosis.name : "tanlanmagan"}`
    ];

    if (drug) {
      const dose = window.Medos.helpers.calculateDose(drug, weight, age);
      lines.push(`Dori: ${drug.name} (${drug.form}, ${drug.strength})`);
      lines.push(`Doza qoidasi: ${drug.doseRule}`);
      lines.push(`Kunlik doza: ${window.Medos.helpers.formatDoseRange(dose.minDailyDose, dose.maxDailyDose)}`);
      lines.push(`Bir martalik doza: ${window.Medos.helpers.formatDoseRange(dose.singleDoseMin, dose.singleDoseMax)}`);
      lines.push(`Qabul soni: kuniga ${dose.frequencyPerDay || "-"} mahal`);

      if (dose.message) {
        lines.push(`Eslatma: ${dose.message}`);
      }

      if (dose.warnings && dose.warnings.length) {
        lines.push(`Ogohlantirish: ${dose.warnings.join(" ")}`);
      }
    }

    return lines.join("\n");
  }
};
