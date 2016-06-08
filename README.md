# CEV-Model
Pricing European Call Option in the CEV model.
Computing implied volatility of the model.


# Français

La dynamique
============

On suppose que l’actif risqué est régi par l’équation différentielle stochastique :
$$dS\_t = \\mu S\_t dt + \\sigma \\sqrt{S\_t} dW\_t,
\\label{1}$$
 où (*W*<sub>*t*</sub>) est un mouvement brownien standard défini sur \[0, +∞\[. La fonction $x\\mapsto \\sigma\\sqrt x$ n’étant pas lipschitzienne, le théorème 3.5.3 d’Itô ne peut s’appliquer. Mais le théorème 6.2.3 assure que, grâce au caractère hölderien de cette fonction, il existe néanmoins un unique processus continu adapté (*S*<sub>*t*</sub>) vérifiant $\\eqref{1}$ et *S*<sub>0</sub> = *x*, et ce pour tout *x* ≥ 0.

Le processus (*S*<sub>*t*</sub>) est à valeurs dans ℝ<sub>+</sub>, et on considèrera dans la suite *S*<sub>0</sub> = *x*. Contrairement au modèle de Black-Scholes, celui-ci peut valoir 0. En effet, soit *τ*<sub>0</sub> le temps d’arrêt défini par :
*τ*<sub>0</sub> = inf{*t* ≥ 0|*S*<sub>*t*</sub> = 0}.
 Alors, la proposition 6.2.4 affirme que :

1.  Si *μ* &gt; 0, alors ℙ(*τ*<sub>0</sub> &lt; +∞) ∈ \]0, 1\[ ;

2.  Si *μ* ≤ 0, alors ℙ(*τ*<sub>0</sub> &lt; +∞) = 1.

En outre, *S*<sub>*t*</sub> est ℙ-p.s. nul à partir de *τ*<sub>0</sub>. En effet, à partir de *τ*<sub>0</sub>, le processus nul est une solution à $\\eqref{1}$ nulle en *τ*<sub>0</sub>, qui est la seule en vertu du théorème 6.2.3. Donc par unicité, *S*<sub>*t*</sub> est bien égal à ce processus à partir de *τ*<sub>0</sub>.

Probabilité risque neutre
=========================

On pose $\\widetilde{S\_t} = e^{-rt}S\_t$ le prix actualisé de l’actif. On a alors:
$$\\begin{aligned}
    d\\widetilde{S\_t} & = -re^{-rt}S\_tdt + e^{-rt}dS\_t  + 0\\\\
     &=  -r\\widetilde{S\_t}dt + \\widetilde{S\_t}(\\mu dt) + \\sigma e^{\\frac{-rt}{2}}\\sqrt{\\widetilde{S\_t}}dW\_t \\\\
     &= \\widetilde{S\_t} (\\mu -r) dt +\\sigma e^{\\frac{-rt}{2}}\\sqrt{\\widetilde{S\_t}}dW\_t \\end{aligned}$$

On cherche à ce que $\\widetilde{S\_t}$ soit une martingale. En vertu de la proposition 3.4.9, on cherche donc à annuler le terme en *d**t*. Pour ce faire, on choisit $d\\widetilde{W}\_t = dW\_t + \\theta\_tdt$. On obtient alors :
$$\\widetilde{S}\_t = \\sqrt{\\widetilde{S\_t}}\\left((\\mu-r)\\sqrt{\\widetilde{S\_t}}-\\sigma e^{-\\frac{rt}{2}}\\theta\_t\\right)dt + \\sigma e^{-\\frac{rt}{2}}\\sqrt{\\widetilde{S\_t}}d\\widetilde{W\_t}$$

On choisit donc $\\theta\_t = \\left(\\frac{\\mu-r}{\\sigma}\\right)e^{\\frac{rt}{2}}\\sqrt{\\widetilde{S\_t}}$. D’où :
$$\\widetilde{W\_t} = W\_t + \\int\_0^t \\left(\\frac{\\mu-r}{\\sigma}\\right)e^{\\frac{rs}{2}}\\sqrt{\\widetilde{S\_s}}ds,$$

Notons alors ℙ<sup>\*</sup> la probabilité de densité $\\frac{d\\mathbb{P}^\*}{d\\mathbb{P}} = \\exp\\left(-\\int\_0^t\\theta\_sdW\_s - \\frac{1}{2}\\int\_0^t\\theta^2\_sds\\right)$ par rapport à ℙ. Alors, en vertu du théorème de Girsanov, si cette densité est une
