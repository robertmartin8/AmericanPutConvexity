"""Reproduce the paper's exact-formula illustration (not a PDE simulation).

Run from any directory with the dependencies in requirements.txt installed.
All output paths are resolved relative to this script. No randomness is used.
The high-precision sign checks are numerical evidence, not Lean certificates.
"""

from __future__ import annotations

import csv
import json
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import mpmath as mp
import numpy as np


ROOT = Path(__file__).resolve().parents[1]
CASES = [
    {"label": "h=0", "k": 1.0, "h": 0.0, "c": 1.0, "d": -0.05},
    {"label": "h=1/2", "k": 1.0, "h": 0.5, "c": 1.0, "d": -0.05},
    {"label": "h=1", "k": 1.0, "h": 1.0, "c": 1.0, "d": -0.05},
    {"label": "h=6/5", "k": 1.0, "h": 1.2, "c": 10.0,
     "d": float(np.log(5.0 / 6.0) - 0.02)},
]


def profile(z, beta, rho):
    if rho == 0:
        return np.ones_like(z, dtype=float)
    gap = np.sqrt(beta * beta + 4 * rho)
    plus, minus = (-beta + gap) / 2, (-beta - gap) / 2
    return (plus * np.exp(minus * z) - minus * np.exp(plus * z)) / gap


def initial_difference(x, case):
    k, h, c, d = (case[key] for key in ("k", "h", "c", "d"))
    alpha = k - h - 1
    z = x - d
    f = profile(z, alpha - c, k)
    g = profile(z, alpha + 2 - c, h)
    payoff = np.maximum(-np.expm1(x), 0)
    return (payoff - f + np.exp(x) * g) / f


def mp_difference(x_string, case, precision):
    with mp.workdps(precision):
        k, h, c = (mp.mpf(str(case[key])) for key in ("k", "h", "c"))
        d = mp.log(mp.mpf(5) / 6) - mp.mpf(1) / 50 if h > k else -mp.mpf(1) / 20
        x = mp.mpf(x_string)
        z, alpha = x - d, k - h - 1

        def exact_profile(beta, rho):
            if rho == 0:
                return mp.mpf(1)
            gap = mp.sqrt(beta * beta + 4 * rho)
            plus, minus = (-beta + gap) / 2, (-beta - gap) / 2
            return (plus * mp.exp(minus * z) - minus * mp.exp(plus * z)) / gap

        f = exact_profile(alpha - c, k)
        g = exact_profile(alpha + 2 - c, h)
        value = (max(-mp.expm1(x), 0) - f + mp.exp(x) * g) / f
        return mp.nstr(value, precision - 5)


def positive_runs(x, values, threshold=1e-9):
    mask = values > threshold
    starts = np.flatnonzero(mask & ~np.r_[False, mask[:-1]])
    ends = np.flatnonzero(mask & ~np.r_[mask[1:], False])
    return [
        {"first_positive_sample": float(x[i]), "last_positive_sample": float(x[j]),
         "sampled_maximum": float(np.max(values[i:j + 1]))}
        for i, j in zip(starts, ends)
    ]


def main():
    figures = ROOT / "figures"
    figures.mkdir(exist_ok=True)
    report = {
        "description": "Initial comparison profiles evaluated from closed-form exponentials; no price PDE solved.",
        "threshold": 1e-9,
        "precision_digits": [50, 100],
        "case_parameters": CASES,
        "control_exact_parameters": {"k": "1", "h": "6/5", "c": "10", "d": "log(5/6)-1/50"},
        "sampled_checks": [],
        "control_sign_checks": [],
        "numpy_version": np.__version__, "matplotlib_version": matplotlib.__version__,
        "mpmath_version": mp.__version__,
    }
    csv_rows = []
    for case in CASES:
        left = float(np.log(case["k"] / case["h"])) if case["h"] > case["k"] else 0.0
        right = 0.36 if case["h"] > case["k"] else 4.0
        counts = []
        for size in (5001, 10001):
            x = np.linspace(left, right, size)
            v = initial_difference(x, case)
            assert np.all(np.isfinite(v))
            runs = positive_runs(x, v)
            counts.append(len(runs))
            report["sampled_checks"].append({"case": case["label"], "grid_points": size, "runs": runs})
            if size == 10001:
                csv_rows.extend((case["label"], float(xx), float(vv)) for xx, vv in zip(x, v))
        expected = 2 if case["h"] > case["k"] else 1
        assert counts == [expected, expected], (case, counts)

    control = CASES[-1]
    # Three separated interior points witness +,-,+, well above roundoff.
    for x_string, expected_sign in [("-0.07", 1), ("-0.005", -1), ("0.1", 1)]:
        low = mp_difference(x_string, control, 50)
        high = mp_difference(x_string, control, 100)
        with mp.workdps(110):
            assert mp.sign(mp.mpf(high)) == expected_sign
            assert abs(mp.mpf(low) - mp.mpf(high)) < mp.mpf("1e-43")
        ordinary = float(initial_difference(np.array([float(x_string)]), control)[0])
        assert abs(ordinary - float(high)) < 2e-14
        report["control_sign_checks"].append({"x": x_string, "v_50_digits": low, "v_100_digits": high})

    with (ROOT / "numerics" / "initial_profiles.csv").open("w", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(["case", "x", "v_x_0"])
        writer.writerows(csv_rows)
    with (ROOT / "numerics" / "initial_profiles_checks.json").open("w") as stream:
        json.dump(report, stream, indent=2)
        stream.write("\n")

    plt.rcParams.update({"font.family": "DejaVu Serif", "mathtext.fontset": "dejavuserif",
                         "font.size": 9, "axes.labelsize": 9, "axes.titlesize": 10,
                         "legend.fontsize": 8, "xtick.labelsize": 8, "ytick.labelsize": 8,
                         "axes.spines.top": False, "axes.spines.right": False,
                         "pdf.fonttype": 42})
    fig, axes = plt.subplots(1, 2, figsize=(7.1, 2.95), layout="constrained")
    colors = ["#0072B2", "#D55E00", "#009E73"]
    for case, color, style, label in zip(CASES[:3], colors, ["-", "--", "-."],
                                        [r"$h=0$", r"$h=1/2$", r"$h=1$"]):
        x = np.linspace(0, 4, 10001)
        axes[0].plot(x, initial_difference(x, case), label=label, color=color, ls=style, lw=1.7)
    axes[0].set(title=r"(a) $0\leq h\leq k$", xlabel=r"Log-price $x$", ylabel=r"Initial difference $v(x,0)$")
    axes[0].legend(frameon=False, loc="lower left")

    b0 = float(np.log(5.0 / 6.0))
    x = np.linspace(b0, 0.36, 10001)
    v = initial_difference(x, control)
    color = "#7A3E65"
    axes[1].plot(x, v, color=color, lw=1.7)
    axes[1].fill_between(x, 0, v, where=v > 0, color=color, alpha=0.12)
    axes[1].axvline(0, color="0.65", lw=0.8, ls=":")
    axes[1].set(title=r"(b) $h=6/5>k$", xlabel=r"Log-price $x$", ylabel=r"Initial difference $v(x,0)$")
    for ax in axes:
        ax.axhline(0, color="0.25", lw=0.7, zorder=0)
        ax.grid(axis="y", color="0.9", lw=0.5)

    inset = axes[1].inset_axes([0.12, 0.56, 0.35, 0.30])
    zoom_x = np.linspace(-0.15, 0, 1501)
    zoom_v = initial_difference(zoom_x, control)
    inset.plot(zoom_x, zoom_v, color=color, lw=1.2)
    inset.fill_between(zoom_x, 0, zoom_v, where=zoom_v > 0, color=color, alpha=0.2)
    inset.axhline(0, color="0.25", lw=0.6)
    inset.set_title("Below-strike detail", fontsize=7, pad=3)
    inset.set_xticks([-0.15, -0.075, 0], labels=["−0.15", "−0.075", "0"])
    inset.tick_params(labelsize=6)
    inset.ticklabel_format(axis="y", style="sci", scilimits=(-4, -4), useMathText=True)
    inset.yaxis.get_offset_text().set_fontsize(6)
    inset.set_facecolor("white")
    fig.savefig(figures / "initial-comparison.pdf", metadata={"Title": "Initial straight-line comparison profiles", "Author": "Robert Martin"})
    fig.savefig(figures / "initial-comparison.png", dpi=220)
    plt.close(fig)
    print(json.dumps({"sampled_positive_runs": [1, 1, 1, 2],
                      "control_sign_checks": report["control_sign_checks"]}, indent=2))


if __name__ == "__main__":
    main()
